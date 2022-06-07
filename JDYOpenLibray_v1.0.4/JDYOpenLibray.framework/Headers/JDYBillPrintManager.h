//
//  JDYBillPrintManager.h
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JDYBlueToothModel : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *type;//"bluetooth"
@property(nonatomic, copy) NSString *address;//uuid/ip地址
@property(nonatomic, copy) NSString *networkIp;//网络打印机ip
@property(nonatomic, copy) NSString *networkPort;//网络打印机端口号
@property(nonatomic, copy) NSString *printDeviceId;//打印机编号
@end


@interface JDYBillPrintManager : NSObject

+(void)selectPrinterWitType:(NSString*)type
              printDeviceId:(NSString*)printDeviceId
             selectCallBack:(void(^)(JDYBlueToothModel *blueToothModel))selectCallBack
             cancelCallBack:(void(^)(void))cancelCallBack;

+(void)getPrinterWithDeviceId:(NSString*)printDeviceId callBack:(void(^)(NSArray* printList))callBack;

//只支持hex
+(void)printDatasWithData:(NSString*)data
          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
           failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId,int errCode, NSString * errMsg))failedCallBack;

//data支持base64/hex
+(void)printMutableDatasWithData:(NSString*)dataStr
          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
           failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId,int errCode, NSString * errMsg))failedCallBack;
@end



