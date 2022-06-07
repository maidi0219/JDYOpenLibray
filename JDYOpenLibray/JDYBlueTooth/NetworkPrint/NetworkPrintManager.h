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

-(void)writeData:(NSData *)data ip:(NSString*)ip port:(NSString*)port writeDataBlock:(NetworkPrintWriteDataBlock)writeDataBlock;

//手动断开Socket连接
- (void)socketDisconnectSocket;
@end

