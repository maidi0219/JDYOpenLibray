//
//  BlueToothListController.h
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/12.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueToothManager.h"

typedef void(^ConnectFinidhedBlock)(CBPeripheral *peripheral);
typedef void(^ConnectCancelBlock)(void);
@interface BlueToothListController : UITableViewController
@property(nonatomic)ConnectFinidhedBlock connectFinishBlock;// 蓝牙连接完毕的回调
@property(nonatomic)ConnectCancelBlock connectCancelBlock;// 蓝牙连接取消
@end

