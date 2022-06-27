//
//  NetworkPrintManager.h
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/6/6.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkPrintManager : NSObject
+ (instancetype)sharedInstance;

typedef void(^NetworkPrintWriteDataBlock)(NSString* errorStr);

/// 网络打印机写入数据
/// @param data base64数据格式
/// @param ip 网络打印机ip地址
/// @param port 网络打印机端口号
/// @param writeDataBlock 写入数据回调
-(void)writeData:(NSData *)data ip:(NSString*)ip port:(NSString*)port writeDataBlock:(NetworkPrintWriteDataBlock)writeDataBlock;

//手动断开Socket连接
- (void)socketDisconnectSocket;
@end

