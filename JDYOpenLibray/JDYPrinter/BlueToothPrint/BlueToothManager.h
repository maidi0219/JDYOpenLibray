//
//  BlueToothManager.h
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/12.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define Notify_BLEPeripherals_Update @"Notify_BLEPeripherals_Update"
#define Notify_BLEConnectPeripheral_Changed @"Notify_BLEConnectPeripheral_Changed"
#define Notify_BLEConnectPeripheral_AllReady @"Notify_BLEConnectPeripheral_AllReady"
#define Notify_BLEPrint_Error @"Notify_BLEPrint_Error"

@interface BlueToothManager : NSObject
typedef void(^SearchPeripheralFinishBlock)(CBPeripheral *peripheral,NSError* error);
typedef void(^SearchCharacteristicFinishBlock)(CBCharacteristic *characteristic ,NSError* error);

typedef void(^WriteDataBlock)(NSString * errMsg);

+ (instancetype)sharedInstance;

//开始扫描外设列表
-(void)startScan;

//停止扫描外设列表
-(void)stopScan;

//外设列表
@property(nonatomic,strong)NSMutableArray *peripheralList;

//当前连接的外设一个
@property(nonatomic)CBPeripheral *currentPeripheral;

/// 连接外设
/// @param peripheral 外设对象
/// @param finishBlock 连接完成回调
-(void)connectAndSearchPeripheralCharacteristic:(CBPeripheral*)peripheral finishBlock:(SearchCharacteristicFinishBlock)finishBlock;

/// 外设连接
/// @param peripheral 外设对象
-(void)connectPeripheral:(CBPeripheral *)peripheral;

/// 断开外设连接
/// @param peripheral 外设对象
- (void)disConnectPeripheral:(CBPeripheral *)peripheral;


/// 往外设写入数据
/// @param data 字节流数据
/// @param name 外设名称
/// @param uuid 外设uuid
/// @param writeDataBlock 写入数据回调
-(void)writeData:(NSData *)data peripheralName:(NSString*)name uuid:(NSString*)uuid writeDataBlock:(WriteDataBlock)writeDataBlock;


/// 搜索外设并连接
/// @param uuidString uuidString
/// @param finishBlock 成功回调
-(void)searchPeripheralWithUUid:(NSString*)uuidString finishBlock:(SearchPeripheralFinishBlock)finishBlock;

@end


