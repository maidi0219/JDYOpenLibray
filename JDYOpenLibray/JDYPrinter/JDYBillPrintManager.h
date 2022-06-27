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


/// 选择打印机界面
/// @param type blueTooth、network
/// @param printDeviceId 设备id
/// @param selectCallBack 选择回调
/// @param cancelCallBack 取消回调
+(void)selectPrinterWitType:(NSString*)type
              printDeviceId:(NSString*)printDeviceId
             selectCallBack:(void(^)(JDYBlueToothModel *blueToothModel))selectCallBack
             cancelCallBack:(void(^)(void))cancelCallBack;

/// 获取本地存储的打印机设备列表
/// @param printDeviceId 设备id
/// @param callBack 回调
+(void)getPrinterWithDeviceId:(NSString*)printDeviceId callBack:(void(^)(NSArray* printList))callBack;

//(旧)只支持hex
//+(void)printDatasWithData:(NSString*)data
//          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
//           failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId,int errCode, NSString * errMsg))failedCallBack;


/// 数据打印data支持base64/hex
/// @param dataStr jsonstr格式参考文档
/// @param succeedCallBack 成功回调
/// @param failedCallBack 失败回调
+(void)printMutableDatasWithData:(NSString*)dataStr
          succeedCallBack:(void(^)(NSString *traceId, NSString *printDeviceId))succeedCallBack
           failedCallBack:(void(^)(NSString * traceId, NSString * printDeviceId,int errCode, NSString * errMsg))failedCallBack;
@end



