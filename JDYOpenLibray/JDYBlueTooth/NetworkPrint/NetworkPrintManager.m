//
//  NetworkPrintManager.m
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/6/6.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "NetworkPrintManager.h"
#import "AsyncSocket.h"

typedef void(^NetworkPrintConnetFinishBlock)(NSString* errorStr);

@interface NetworkPrintManager()<AsyncSocketDelegate>

@property (nonatomic, strong) AsyncSocket *asyncSocket;

@property(nonatomic) NetworkPrintConnetFinishBlock connetFinishBlock;

@property(nonatomic) NetworkPrintWriteDataBlock writeDataBlock;
@end

static NetworkPrintManager *instance = nil;

@implementation NetworkPrintManager{
    int _connectTime;
}

+ (instancetype)sharedInstance{
    return [[self alloc] init];
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        instance.asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
        [instance.asyncSocket setRunLoopModes:@[NSRunLoopCommonModes]];
    });
    return instance;
}

//连接打印机
-(void)socketConnectToPrint:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout {
    NSError *error = nil;
    [self.asyncSocket connectToHost:host onPort:port withTimeout:timeout error:&error];
}
//检查连接状态
-(BOOL)socketIsConnect{
    BOOL isConn = [self.asyncSocket isConnected];
    if (isConn) {
        NSLog(@"host=%@\nport=%hu\nlocalHost=%@\nlocalPort=%hu",self.asyncSocket.connectedHost,self.asyncSocket.connectedPort,self.asyncSocket.localHost,self.asyncSocket.localPort);
    }
    return isConn;
}
//发送数据
- (void)socketWriteData:(NSData *)data {
    [self.asyncSocket writeData:data withTimeout:-1 tag:0];
}
//手动断开连接
- (void)socketDisconnectSocket {
    [self.asyncSocket disconnect];
}

#pragma mark - Delegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
//    [sock disconnectAfterWriting];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
  
}
//
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
    return YES;
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"读取完成");
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (self.writeDataBlock) {
        self.writeDataBlock(nil);
    }
    NSLog(@"写入完成");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    NSLog(@"即将断开");
}


-(void)writeData:(NSData *)data ip:(NSString*)ip port:(NSString*)port writeDataBlock:(NetworkPrintWriteDataBlock)writeDataBlock{
    self.writeDataBlock = writeDataBlock;
    if ([self socketIsConnect]) {
         [self.asyncSocket writeData:data withTimeout:-1 tag:0];
    }else{
        __weak typeof(self) wkSelf = self;
        [self socketConnectWithIp:ip port:port finishBlock:^(NSString *errorStr) {
            if (errorStr) {
                if (writeDataBlock) {
                    writeDataBlock(errorStr);
                }
            }else{
                [wkSelf.asyncSocket writeData:data withTimeout:-1 tag:0];
            }
           
        }];
        // 启动一个定时器检测是否连接成功
        _connectTime =0;
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerRepeatCheck:) userInfo:nil repeats:YES];
    }
}

-(void)socketConnectWithIp:(NSString*)ip port:(NSString*)port finishBlock:(NetworkPrintConnetFinishBlock)finishBlock{
    self.connetFinishBlock = finishBlock;
    //socket连接
    [self socketConnectToPrint:ip port:(UInt16)[port integerValue] timeout:10];
}

-(void)timerRepeatCheck:(NSTimer *)timer{
    _connectTime++;
    if ([self socketIsConnect]) {
        if (self.connetFinishBlock) {
            self.connetFinishBlock(nil);
        }
        [timer invalidate];
        return;
    }
    // 超过重复次数，认为搜索失败。
    if (_connectTime > 10 ){
        if (self.connetFinishBlock) {
            self.connetFinishBlock(@"网络打印机连接超时");
        }
        [timer invalidate];
    }
}

@end
