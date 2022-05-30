//
//  JDYBillPrintManager.m
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "JDYBillPrintManager.h"
#import "BlueToothListController.h"
#import "BlueToothManager.h"

#define LocalBlueToothListKey @"LocalBlueToothListKey"


typedef NS_ENUM(NSInteger, JDYPrintErrorCodeNum) {
    JDYPrintErrorCodeNumParamError = 1001,     //请求参数错误
    JDYPrintErrorCodeNumNotConnectError,       //未设置打印机
    JDYPrintErrorCodeNumPrinterConnecrError,   //打印机连接异常
    JDYPrintErrorCodeNumPrintDataError,       //打印异常
};

@implementation JDYBillPrintManager

+(void)selectPrinterWitType:(NSString*)type
              printDeviceId:(NSString*)printDeviceId
             selectCallBack:(void(^)(JDYBlueToothModel *blueToothModel))selectCallBack
             cancelCallBack:(void(^)(void))cancelCallBack{
    BlueToothListController *periList = [[BlueToothListController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:periList];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:nav animated:YES completion:nil];
    periList.connectFinishBlock = ^(CBPeripheral *perpheral){
        JDYBlueToothModel *model =[[JDYBlueToothModel alloc]init];
        model.address =perpheral.identifier.UUIDString;
        model.name =perpheral.name;
        model.printDeviceId = printDeviceId;
        model.type = type;
        if (selectCallBack) {
            selectCallBack(model);
        }
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:model.address forKey:@"address"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.printDeviceId forKey:@"printDeviceId"];
        [dic setValue:model.type forKey:@"type"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *list = [[userDefaults objectForKey:LocalBlueToothListKey] mutableCopy];
        if (!list) {
            list =[[NSMutableArray alloc]init];
        }
        BOOL isExt = NO;
        for (int i =0; i<list.count; i++) {
            NSDictionary *ldic = list[i];
            NSString *printDeviceId =[ldic objectForKey:@"printDeviceId"];
            if ([printDeviceId isEqualToString:model.printDeviceId]) {
                [list replaceObjectAtIndex:i withObject:dic];
                isExt = YES;
            }
        }
        if (!isExt) {
            [list addObject:dic];
        }
        [userDefaults setObject:list forKey:LocalBlueToothListKey];
        [userDefaults synchronize];
        NSLog(@"%@", list);
    };
    periList.connectCancelBlock = ^{
        if (cancelCallBack) {
            cancelCallBack();
        }
    };
}
+(NSArray*)localPrintList{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *list = [userDefaults objectForKey:LocalBlueToothListKey];
    NSMutableArray *tprintList = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in list) {
        JDYBlueToothModel *model =[[JDYBlueToothModel alloc]init];
        model.address =[dic objectForKey:@"address"];
        model.name =[dic objectForKey:@"name"];
        model.printDeviceId = [dic objectForKey:@"printDeviceId"];
        model.type = [dic objectForKey:@"type"];
        [tprintList addObject:model];
        
    }
    return [tprintList copy];
}
//获取本地存储信息
+(void)getPrinterWithDeviceId:(NSString*)printDeviceId callBack:(void(^)(NSArray* printList))callBack{
    NSArray *list = [self localPrintList];
    if (printDeviceId.length ==0) {//@""返回全部
        if (callBack) {
            callBack(list);
        }
        return;
    }
    
    NSMutableArray *tprintList =[[NSMutableArray alloc]init];
    for (JDYBlueToothModel *model in list) {
        if ([printDeviceId isEqualToString:model.printDeviceId ]) {
            [tprintList addObject:model];
        }
    }
    if (callBack) {
        callBack([tprintList copy]);
    }
}

+(void)printDatasWithData:(NSString*)dataStr
          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
           failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId, int errCode, NSString * errMsg))failedCallBack{
    NSDictionary *dic=  [self dictionaryWithJsonString:dataStr];
    NSDictionary *dataDic =[dic objectForKey:@"data"];
    NSString *printDeviceId = [dataDic objectForKey:@"printDeviceId"];
    NSString *traceId = [dataDic objectForKey:@"traceId"];
    NSArray *printInfoDics= [dataDic objectForKey:@"printInfo"];
    if (!dataDic || !printDeviceId || !traceId || !printInfoDics) {
        if (failedCallBack) {
            failedCallBack(nil,nil ,JDYPrintErrorCodeNumParamError,@"请求参数错误");
        }
        return;
    }
    [self getPrinterWithDeviceId:printDeviceId callBack:^(NSArray *printList) {
        if (printList.count ==0) {
            if (failedCallBack) {
                failedCallBack(traceId,printDeviceId ,JDYPrintErrorCodeNumNotConnectError,@"未设置打印机");
            }
            return;
        }else{
            [self printInfoDicWithToothModel:printList.firstObject idex:0 printInfoDics:printInfoDics compeleteBlcok:^(int errCode,NSString *errMsg) {
                if (errMsg) {
                    if (failedCallBack) {
                        failedCallBack(traceId,printDeviceId,errCode,errMsg);
                    }
                }else{
                    if (succeedCallBack) {
                        succeedCallBack(traceId,printDeviceId);
                    }
                }
            }];
        }
    }];
}


+(void)printInfoDicWithToothModel:(JDYBlueToothModel*)model idex:(NSInteger)index printInfoDics:(NSArray*)printInfoDics compeleteBlcok:(void(^)(int errCode,NSString * errMsg))compeleteBlcok{
    __block NSInteger i = index;
    i++;
    NSDictionary *dic =printInfoDics[index];
    NSString *dataStr =[dic objectForKey:@"data"];
    NSData *data =[self dataWithHexString:dataStr];
    if (!data && compeleteBlcok) {
        compeleteBlcok(JDYPrintErrorCodeNumParamError,@"打印数据data为空，或者数据data格式异常");
        return;
    }
    NSInteger times =[[dic objectForKey:@"times"] intValue];
    if (times ==0) {
        times =1;
    }
    [self printDatasWithtimes:times data:data model:model block:^(NSString *errMsg) {
      
        if (errMsg) {
            if (compeleteBlcok) {
                compeleteBlcok(JDYPrintErrorCodeNumPrinterConnecrError,errMsg);
            }
            //报错之后不再往下执行
            return;
        }else{
            if (printInfoDics.count ==i) {
                //全部打印完成回调
                if (compeleteBlcok) {
                    compeleteBlcok(0,nil);
                }
            }
        }
        if (i < printInfoDics.count) {//递归调用
            [self printInfoDicWithToothModel:model idex:i printInfoDics:printInfoDics compeleteBlcok:compeleteBlcok];
        }
    }];
}

+(void)printMutableDatasWithData:(NSString*)dataStr
          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
                  failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId,int errCode, NSString * errMsg))failedCallBack{
    NSDictionary *dic=  [self dictionaryWithJsonString:dataStr];
    NSDictionary *dataDic =[dic objectForKey:@"data"];
    NSString *printDeviceId = [dataDic objectForKey:@"printDeviceId"];
    NSString *traceId = [dataDic objectForKey:@"traceId"];
    NSArray *printInfoDics= [dataDic objectForKey:@"printInfo"];
    if (!dataDic || !printDeviceId || !traceId || !printInfoDics) {
        if (failedCallBack) {
            failedCallBack(nil,nil ,JDYPrintErrorCodeNumParamError,@"请求参数错误");
        }
        return;
    }
    [self getPrinterWithDeviceId:printDeviceId callBack:^(NSArray *printList) {
        if (printList.count ==0) {
            if (failedCallBack) {
                failedCallBack(traceId,printDeviceId ,JDYPrintErrorCodeNumNotConnectError,@"未设置打印机");
            }
            return;
        }else{
            [self printMutableInfoDicWithToothModel:printList.firstObject idex:0 printInfoDics:printInfoDics compeleteBlcok:^(int errCode,NSString *errMsg) {
                if (errMsg) {
                    if (failedCallBack) {
                        failedCallBack(traceId,printDeviceId,errCode,errMsg);
                    }
                }else{
                    if (succeedCallBack) {
                        succeedCallBack(traceId,printDeviceId);
                    }
                }
            }];
        }
    }];
    
}

+(void)printMutableInfoDicWithToothModel:(JDYBlueToothModel*)model idex:(NSInteger)index printInfoDics:(NSArray*)printInfoDics compeleteBlcok:(void(^)(int errCode,NSString * errMsg))compeleteBlcok{
    __block NSInteger i = index;
    i++;
    NSDictionary *printInfoDic =printInfoDics[index];
    NSArray *detailDics =[printInfoDic objectForKey:@"details"];//其实目前只会有一个dic，可以直接拿一个？
    __block NSInteger times =[[printInfoDic objectForKey:@"times"] intValue];//打印次数
    if (!detailDics && compeleteBlcok) {
        compeleteBlcok(JDYPrintErrorCodeNumParamError,@"请求参数错误");
        return;
    }
    if (times ==0) {
        times =1;
    }
    [self printDatasInTimes:times toothModel:model detailDics:detailDics compeleteBlcok:^(int errCode, NSString *errMsg) {
        if (errMsg) {
            if (compeleteBlcok) {
                compeleteBlcok(JDYPrintErrorCodeNumPrinterConnecrError,errMsg);
            }
            //报错之后不再往下执行
            return;
        }else{
            //errCode =0表示details全部打印完成，。
            if (i <printInfoDics.count) {
                [self printMutableInfoDicWithToothModel:model idex:i printInfoDics:printInfoDics compeleteBlcok:compeleteBlcok];
            }else{
                if (printInfoDics.count ==i) {
                    //全部printInfoDics打印完成回调
                    if (compeleteBlcok) {
                        compeleteBlcok(0,nil);
                    }
                }
            }
   
        }

    }];
}

+(void)printDatasInTimes:(NSInteger)times toothModel:(JDYBlueToothModel*)model detailDics:(NSArray*)detailDics compeleteBlcok:(void(^)(int errCode,NSString * errMsg))compeleteBlcok{
    if (times <=0) {
        //全部detailDics打印完成times次回调
        if (compeleteBlcok) {
            compeleteBlcok(0,nil);
        }
        return;
    }
    NSData *data =nil;
    __block NSInteger newTimes = times;
    for (int j = 0 ;j<detailDics.count ;j++) {
        NSDictionary *detailDic =detailDics[j];
        NSString *encryptionType =[detailDic objectForKey:@"encryptionType"];//可能是hex或者是base64
        NSString *dataType =[detailDic objectForKey:@"dataType"];//只支持text设备不支持image
        if (![dataType isEqualToString:@"text"]) {
            if (compeleteBlcok) {
                compeleteBlcok(JDYPrintErrorCodeNumParamError,@"请求参数错误");
            }
            return;
        }else{
            if([encryptionType isEqualToString:@"hex"]){
                NSString *dataStr =[detailDic objectForKey:@"data"];
                data = [self dataWithHexString:dataStr];
            }else if([encryptionType isEqualToString:@"base64"]){
                data = [[NSData alloc] initWithBase64EncodedString:[detailDic objectForKey:@"data"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            }
        }
        if (!data && compeleteBlcok) {
            compeleteBlcok(JDYPrintErrorCodeNumParamError,@"打印数据data为空，或者数据data格式异常");
            return;
        }
        __weak typeof(self) wkSelf = self;
        [self printDataWithData:data model:model block:^(NSString *errMsg) {
         
            if (errMsg) {
                if (compeleteBlcok) {
                    compeleteBlcok(JDYPrintErrorCodeNumPrinterConnecrError,errMsg);
                }
                //报错之后不再往下执行
                return;
            }else{
                if (j== detailDics.count-1) {
                    newTimes --;
                    //递归调用
                    [wkSelf printDatasInTimes:newTimes toothModel:model detailDics:detailDics compeleteBlcok:compeleteBlcok];
                    
                }
            }
        }];
    }
}


+(void)printDatasWithtimes:(NSInteger)times data:(NSData*)data model:(JDYBlueToothModel*)model block:(void(^)(NSString *errMsg))block{
    __block NSInteger t = times;
    if (t>0) {
        __weak typeof(self) wkSelf = self;
        [[BlueToothManager sharedInstance]writeData:data peripheralName:model.name uuid:model.address writeDataBlock:^(NSString *errMsg) {
            if (errMsg) {
                if (block) {
                    block(errMsg);
                }
                return;
            }
            t--;
            [wkSelf printDatasWithtimes:t data:data model:model block:block];
            if (t==0) {//打印完成一次个InfoDic
                if (block) {
                    block(nil);
                }
            }
        }];
    }
}

+(void)printDataWithData:(NSData*)data model:(JDYBlueToothModel*)model block:(void(^)(NSString *errMsg))block{
    [[BlueToothManager sharedInstance]writeData:data peripheralName:model.name uuid:model.address writeDataBlock:^(NSString *errMsg) {
        if (errMsg) {
            if (block) {
                block(errMsg);
            }
            return;
        }
        if (block) {
            block(nil);
        }
    }];
}




/**
 *    @brief    将字符表示的16进制数转化为二进制数据
 *
 *    @param     hexString     字符表示的16进制数，长度必须为偶数
 *
 *    @return    二进制数据
 */
+ (NSData *)dataWithHexString:(NSString *)hexString{
    if (hexString.length ==0) return nil;
    // hexString的长度应为偶数
    if ([hexString length] % 2 != 0)
        return nil;
    
    NSUInteger len = [hexString length];
    NSMutableData *retData = [[NSMutableData alloc] init];
    const char *ch = [[hexString dataUsingEncoding:NSASCIIStringEncoding] bytes];
    for (int i=0 ; i<len ; i+=2) {
        
        int height=0;
        if (ch[i]>='0' && ch[i]<='9')
            height = ch[i] - '0';
        else if (ch[i]>='A' && ch[i]<='F')
            height = ch[i] - 'A' + 10;
        else if (ch[i]>='a' && ch[i]<='f')
            height = ch[i] - 'a' + 10;
        else
            // 错误数据
            return nil;
        
        int low=0;
        if (ch[i+1]>='0' && ch[i+1]<='9')
            low = ch[i+1] - '0';
        else if (ch[i+1]>='A' && ch[i+1]<='F')
            low = ch[i+1] - 'A' + 10;
        else if (ch[i+1]>='a' && ch[i+1]<='f')
            low = ch[i+1] - 'a' + 10;
        else
            // 错误数据
            return nil;
        
        int byteValue = height*16 + low;
        [retData appendBytes:&byteValue length:1];
    }
    
    return retData;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)paramStrWithDic:(NSDictionary *)dic{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        return nil;
    }
    NSString *paramStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return paramStr;
}



@end

@implementation JDYBlueToothModel
@end
