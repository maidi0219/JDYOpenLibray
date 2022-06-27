//
//  BlueToothListController.m
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/4/12.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "BlueToothListController.h"

#define grayColor  [UIColor colorWithRed:239.0 / 255.0 green:239.0 / 255.0 blue:239.0 / 255.0 alpha:1.0f]

static NSString *identifier = @"peripheralCell";

@interface BlueToothListController ()
@property(nonatomic)BlueToothManager *shareManager;
@property(nonatomic)NSMutableArray *list;
@property(nonatomic)CBPeripheral *operatingPeripheral;
@property(nonatomic)NSTimer *timer;
@end

@implementation BlueToothListController{
    NSMutableArray *_dataList;
}
-(void)dealloc{
    NSLog(@"销毁vc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.shareManager =[BlueToothManager sharedInstance];
    self.list = [[NSMutableArray alloc]initWithCapacity:0];
    [self.shareManager startScan];
    self.list = self.shareManager.peripheralList;
    [self updateDatas];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction) name:Notify_BLEPeripherals_Update object:nil];
    self.title = @"选择打印机";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    self.navigationController.navigationBar.tintColor = [self colorWithRGB:0x212121 alpha:1];
    
    if (!self.shareManager.currentPeripheral) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkPeripheralList:) userInfo:nil repeats:YES];
    }
}

//轮询当前外设列表是否包含了当前uuid-> 连接当前外设
-(void)checkPeripheralList:(NSTimer *)timer{
    for (CBPeripheral *pl in self.list) {
        if ([pl.identifier.UUIDString isEqualToString:self.uuidStr] && pl.state == CBPeripheralStateDisconnected) {
            //关了计时器会有小bug(第一次自动连接完成之后->关掉打印机->再开启打印机不会重连了)
            [timer invalidate];
            
            //此时不能停止扫描外设
            [self.shareManager connectPeripheral:pl];
            break;
        }
    }
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)notificationAction{
    self.list = self.shareManager.peripheralList;
    [self updateDatas];
}
-(void)refresh{
    [self.shareManager stopScan];
    [self.shareManager startScan];
}

-(void)updateDatas{
    _dataList = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *conList =[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *disConList =[[NSMutableArray alloc]initWithCapacity:0];
    [_dataList addObject:conList];
    [_dataList addObject:disConList];
    for (CBPeripheral *pl in self.list) {
        if (pl.state ==CBPeripheralStateConnected) {
            [conList addObject:pl];
        }else{
            [disConList addObject:pl];
        }
    }
    [self.tableView reloadData];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.shareManager stopScan];
    [self.timer invalidate];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.connectCancelBlock) {
        self.connectCancelBlock();
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list =_dataList.count >section? _dataList[section] :nil;
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 30)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor =[self colorWithRGB:0x666666 alpha:1];
    view.backgroundColor = grayColor;
    [view addSubview:titleLabel];
    if (section ==0) {
        titleLabel.text =@"已配对设备";
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -120, 0,120, 30)];
        [rightBtn setTitle:@"查看支持的打印机" forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [rightBtn addTarget:self action:@selector(supportDevice) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleColor:[self colorWithRGB:0x276FF5 alpha:1] forState:UIControlStateNormal];
        [view addSubview:rightBtn];

    }else{
        titleLabel.text = @"未配对设备";
    }
    return view;
}
-(void)supportDevice{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://club.kingdee.com/forum.php?mod=viewthread&tid=1300627"]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
      if (!cell) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
      }
    NSArray *list =_dataList[indexPath.section];
    CBPeripheral *phe = list[indexPath.row];
    cell.textLabel.text = phe.name;
    if (phe.state == CBPeripheralStateConnected && [self.shareManager.currentPeripheral.identifier.UUIDString isEqualToString:phe.identifier.UUIDString]) {
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
//    NSString *str = @"未连接";
//    switch (phe.state) {
//        case CBPeripheralStateConnected:
//            str = @"已连接";
//            break;
//        case CBPeripheralStateConnecting:
//            str = @"正在连接...";
//            break;
//        case CBPeripheralStateDisconnected:
//            str = @"未连接";
//            break;
//
//        default:
//            break;
//    }
    cell.detailTextLabel.text = phe.identifier.UUIDString;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *list =_dataList[indexPath.section];
    CBPeripheral *peripheral = list[indexPath.row];
    self.operatingPeripheral = peripheral;
    if (peripheral.state ==CBPeripheralStateConnected) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:peripheral.name message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"选中"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            [self.shareManager connectAndSearchPeripheralCharacteristic:peripheral finishBlock:^(CBCharacteristic *characteristic, NSError *error) {
                if (self.connectFinishBlock) {
                    self.connectFinishBlock(peripheral);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
        [alertVC addAction:selectAction];
        
        UIAlertAction *breakAction = [UIAlertAction actionWithTitle:@"断开"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            [self.shareManager disConnectPeripheral:peripheral];
        }];
        [alertVC addAction:breakAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else if (peripheral.state==CBPeripheralStateDisconnected){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:peripheral.name message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"连接并选中"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            [self.shareManager connectAndSearchPeripheralCharacteristic:peripheral finishBlock:^(CBCharacteristic *characteristic, NSError *error) {
                if (self.connectFinishBlock) {
                    self.connectFinishBlock(peripheral);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
        [alertVC addAction:selectAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float) (((rgbValue) & 0xFF0000) >> 16)) / 255.0
                           green:((float) (((rgbValue) & 0x00FF00) >> 8)) / 255.0
                            blue:((float) ((rgbValue) & 0x0000FF)) / 255.0
                           alpha:alpha];
}
@end
