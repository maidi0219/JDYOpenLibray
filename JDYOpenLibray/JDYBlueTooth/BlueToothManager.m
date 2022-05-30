//
//  BlueToothManager.m
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/12.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "BlueToothManager.h"

static int CONNECT_REPEAT_NUM = 5; // 连接定时器计数
static int SEARCH_REPEAT_NUM = 10; // 搜索设备定时器计数

@interface BlueToothManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(nonatomic,strong)CBCentralManager *centralManager;

@property (nonatomic, strong)NSTimer *timer;

@property(nonatomic) SearchPeripheralFinishBlock searchPeripheralFinishBlock;
@property(nonatomic) SearchCharacteristicFinishBlock searchCharacteristicFinishBlock;
@end

static BlueToothManager *instance = nil;

@implementation BlueToothManager{
    int _searchPeripheraTime;
    int _searchCharTime;
}

+ (instancetype)sharedInstance{
    return [[self alloc] init];
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        instance.peripheralList = [[NSMutableArray alloc] init];
        [instance resetBLEModel];
    });
    return instance;
}
- (void)resetBLEModel
{
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    [_peripheralList removeAllObjects];
}
-(BOOL)isScaning{
    if (self.centralManager ==nil) {
        return false;
    }
    return self.centralManager.isScanning;
}
-(void)startScan{
    if (_centralManager.state == CBCentralManagerStatePoweredOn) {
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
        return;
    }
    [self resetBLEModel];
}
-(void)stopScan{
    [_centralManager stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral{
    [self.centralManager stopScan];
    NSLog(@"peripheral (%@) connecting...",peripheral.name);
    [self.centralManager connectPeripheral:peripheral options:nil];
}
- (void)disConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"peripheral %@ disconnecting...",peripheral.name);
    [self.centralManager stopScan];
    [self.centralManager cancelPeripheralConnection:peripheral];
}
-(void)searchPeripheralWithUUid:(NSString*)uuidString finishBlock:(SearchPeripheralFinishBlock)finishBlock{
    self.searchPeripheralFinishBlock = finishBlock;
    NSLog(@"search peripheral: %@...",uuidString);
    CBPeripheral *result = [self searchPeripherals:uuidString];
    if (result !=nil) {
        if (finishBlock) {
            finishBlock(result,nil);
            return;
        }
    }
    if (![self isScaning]) {
        [self startScan];
    }
    _searchPeripheraTime = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerSearchPeripherals:) userInfo:uuidString repeats:YES];
}
-(void)timerSearchPeripherals:(NSTimer *)timer{
    _searchPeripheraTime++;
    NSString *uuidString = [timer userInfo];
    CBPeripheral *result = [self searchPeripherals:uuidString];
    if (result !=nil) {
        if (self.searchPeripheralFinishBlock) {
            self.searchPeripheralFinishBlock(result,nil);
            [timer invalidate];
            return;
        }
    }
    // 超过重复次数，认为搜索失败。
    if (_searchPeripheraTime > SEARCH_REPEAT_NUM ){
        self.searchPeripheralFinishBlock(nil, nil);
        [timer invalidate];
    }
}

-(CBPeripheral*)searchPeripherals:(NSString*)uuidString{
    NSLog(@"search peripheral: %@...",uuidString);
    CBPeripheral *result = nil;
    for (CBPeripheral *peripheral in self.peripheralList) {
        if ([peripheral.identifier.UUIDString isEqualToString: uuidString]) {
            result =peripheral;
            break;
        }
    }
    return result;
}

/// 连接并搜索设备的可写特征
/// - Parameters:
///   - peripheral: 设备
///   - finishBlock: 成功回调
-(void)connectAndSearchPeripheralCharacteristic:(CBPeripheral*)peripheral finishBlock:(SearchCharacteristicFinishBlock)finishBlock{
    self.searchCharacteristicFinishBlock = finishBlock;
    if (peripheral.state ==CBPeripheralStateConnected) {
        // 已连接，找设备可写特征
        CBCharacteristic *characteristic = [self searchPeripheralCharacteristics:peripheral];
        if (characteristic !=nil) {
            finishBlock(characteristic,nil);
            return;
        }
        // 没找到可写特征，去搜索
        [peripheral discoverServices:nil];
        
    }else{
        [self connectPeripheral:peripheral];
    }
    // 启动一个定时器
    _searchCharTime =0;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerSearchCharacteristics:) userInfo:peripheral repeats:YES];
    
}

-(void)timerSearchCharacteristics:(NSTimer *)timer{
    _searchCharTime++;
    CBPeripheral *peripheral = [timer userInfo];
    CBCharacteristic *characteristic = [self searchPeripheralCharacteristics:peripheral];
    if (characteristic !=nil) {
        if (self.searchCharacteristicFinishBlock) {
            self.searchCharacteristicFinishBlock(characteristic,nil);
            [timer invalidate];
            return;
        }
    }
    // 超过重复次数，认为搜索失败。
    if (_searchCharTime > CONNECT_REPEAT_NUM ){
        if (self.searchPeripheralFinishBlock) {
            self.searchPeripheralFinishBlock(nil, nil);
        }
        [timer invalidate];
    }
}
/// 遍历查询设备的可写特性: 优先遍历write，没有write，就遍历writeWithoutResponse
/// - Parameter peripheral: 设备
/// - Returns: 可写特性
-(CBCharacteristic*)searchPeripheralCharacteristics:(CBPeripheral *)peripheral{
    if (peripheral.services ==nil) {
        return nil;
    }
    CBCharacteristic *write_withoutresponse_characteristic =nil;
    for (CBService *service in peripheral.services) {
        if (service.characteristics ==nil) {
            continue;
        }
        for (CBCharacteristic * characteristic in service.characteristics) {
            CBCharacteristicProperties properties = characteristic.properties;
            if ([characteristic.UUID.UUIDString isEqualToString:@"FFF2"]||
                [characteristic.UUID.UUIDString isEqualToString:@"49535343-8841-43F4-A8D4-ECBE34729BB3"] ||
                [characteristic.UUID.UUIDString isEqualToString:@"BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F"]) {
                if (properties & CBCharacteristicPropertyWrite) {
                    NSLog(@"characteristic properties contains write:%@", characteristic);
                    return characteristic;
                }
                NSLog(@"%lu",properties & CBCharacteristicPropertyWrite);
                if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
                    write_withoutresponse_characteristic = characteristic;
                }
            }
        
        }
    }
    return write_withoutresponse_characteristic;
}
-(void)writeData:(NSData *)data peripheralName:(NSString*)name uuid:(NSString*)uuid writeDataBlock:(void(^)(NSString * errMsg))writeDataBlock{
    if (data ==nil) {
        NSLog(@"打印数据为空");
        if (writeDataBlock) {
            writeDataBlock(@"打印数据为空");
        }
        return;
    }
    if (uuid == nil || name == nil ) {
        NSLog(@"请先在[设置]->[打印设置]中设置蓝牙打印机");
        if (writeDataBlock) {
            writeDataBlock(@"请先在[设置]->[打印设置]中设置蓝牙打印机");
        }
        return;
    }
    [self searchPeripheralWithUUid:uuid finishBlock:^(CBPeripheral *peripheral, NSError *error) {
        if (peripheral == nil){
            NSLog(@"请确认蓝牙打印机%@电源打开，且未被其它设备连接",name);
            if (writeDataBlock) {
                writeDataBlock([NSString stringWithFormat:@"请确认蓝牙打印机%@电源打开，且未被其它设备连接",name]);
            }
            return;
        }
        [self connectAndSearchPeripheralCharacteristic:peripheral finishBlock:^(CBCharacteristic *characteristic, NSError *error) {
            if (characteristic ==nil) {
                NSLog(@"搜索不到设备可写特征:%@",uuid);
                if (writeDataBlock) {
                    writeDataBlock([NSString stringWithFormat:@"搜索不到设备可写特征:%@",uuid]);
                }
                return;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self sliceWriteData:data peripheral:peripheral characteristic:characteristic];
                if (writeDataBlock) {
                    writeDataBlock(nil);
                }
            });
           
        }];
    }];
}
-(void)sliceWriteData:(NSData*)data peripheral:(CBPeripheral*)peripheral characteristic:(CBCharacteristic*)characteristic{
    CBCharacteristicWriteType writeType = CBCharacteristicWriteWithoutResponse;
    CBCharacteristicProperties properties = characteristic.properties;
    if ((properties & CBCharacteristicPropertyWrite)) {
//        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF2"]) {
            writeType = CBCharacteristicWriteWithResponse;
//        }
       
    }else{
        NSLog(@"print without response");
    }
    NSUInteger maximum = 128;//[peripheral maximumWriteValueLengthForType:writeType];
    long dataLen = data.length;
    long count = dataLen /maximum;
    if (dataLen % maximum > 0){
        count += 1;
    }
    for (int i=0; i<count ;i++) {
        long len = maximum;
        if (i ==count -1) {
            len = dataLen - i*maximum;
        }
        NSRange range = NSMakeRange(i*maximum, len);
        NSData *subData =[data subdataWithRange:range];
        [peripheral writeValue:subData forCharacteristic:characteristic type:writeType];
    }
    
}
-(void)addPeripheral:(CBPeripheral*)peripheral{
    if (peripheral.name ==nil || [peripheral.name lengthOfBytesUsingEncoding:NSUTF8StringEncoding]==0) {
        return;
    }
    BOOL shouldAdd = YES;
    for (CBPeripheral *p in self.peripheralList) {
        if (p.identifier == peripheral.identifier) {
            shouldAdd = NO;
            break;
        }
    }
    if (shouldAdd) {
//        [self.peripheralList insertObject:peripheral atIndex:0];
        [self.peripheralList addObject:peripheral];
        [[NSNotificationCenter defaultCenter]postNotificationName:Notify_BLEPeripherals_Update object:nil];
    }
}

/*
    CBPeripheralDelegate
*/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error{
    for (CBCharacteristic *chart in service.characteristics) {
        [peripheral readValueForCharacteristic:chart];
        [peripheral discoverDescriptorsForCharacteristic:chart];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    NSLog(@"didUpdateValueFor:%@", characteristic);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    NSLog(@"didDiscoverDescriptorsFor:%@", characteristic);
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    NSLog(@"didWriteValueFor:%@", descriptor);
    if (error != nil) {
        NSLog(@"error:%@", error);
    }
}
/*
    CBCentralManagerDelegate
*/
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"CentralManager is initialized");
    switch (central.state) {
        case CBManagerStateUnauthorized:
            NSLog(@"The app is not authorized to use Bluetooth low energy.");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"Bluetooth is currently powered off.");
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"Bluetooth is currently powered on and available to use.");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    [self addPeripheral:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"peripheral %@ connected",peripheral.name);
    //        self.currentConnect = peripheral;
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:Notify_BLEPeripherals_Update object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:Notify_BLEConnectPeripheral_Changed object:nil];
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    NSLog(@"peripheral %@ fail connected",peripheral.name);
    [[NSNotificationCenter defaultCenter]postNotificationName:Notify_BLEPeripherals_Update object:nil];
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
        NSLog(@"peripheral %@  disconnected",peripheral.name);
        //        self.currentConnect = nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:Notify_BLEPeripherals_Update object:nil];
}
@end
