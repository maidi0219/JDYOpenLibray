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

+ (instancetype)sharedInstance;
-(void)startScan;
-(void)stopScan;

@property(nonatomic,strong)NSMutableArray *peripheralList;

-(void)connectAndSearchPeripheralCharacteristic:(CBPeripheral*)peripheral finishBlock:(SearchCharacteristicFinishBlock)finishBlock;

- (void)disConnectPeripheral:(CBPeripheral *)peripheral;

-(void)writeData:(NSData *)data peripheralName:(NSString*)name uuid:(NSString*)uuid writeDataBlock:(void(^)(NSString * errMsg))writeDataBlock;
@end


