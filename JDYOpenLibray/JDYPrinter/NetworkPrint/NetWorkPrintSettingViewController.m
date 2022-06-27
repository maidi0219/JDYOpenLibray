//
//  NetWorkPrintSettingViewController.m
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/6/6.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "NetWorkPrintSettingViewController.h"

@interface NetWorkPrintSettingViewController ()
@property (strong, nonatomic)  UITextField *ipText;
@property (strong, nonatomic)  UITextField *portText;

@end

@implementation NetWorkPrintSettingViewController{
    NSString *_ip;
    NSString *_port;
}

-(void)settingAction:(id)sender {
    if (self.ipText.text.length ==0) {
        NSLog(@"ip地址不能为空");
        return;
    }else if(self.portText.text.length ==0){
        NSLog(@"端口号不能为空");
        return;
    }
    if (self.connectFinishBlock) {
        self.connectFinishBlock(self.ipText.text,self.portText.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配置网络打印机";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self setupViews];
}
-(void)setupViews{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-260)/2, 100, 260, 200)];
    
    UILabel *ipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60,21)];
    ipLabel.text = @"IP地址";
    ipLabel.font = [UIFont systemFontOfSize:17];
    [contentView addSubview:ipLabel];
    
    self.ipText  = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ipLabel.frame)+4, 0, 200, 21)];
    self.ipText.keyboardType = UIKeyboardTypeNumberPad;
    self.ipText.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:self.ipText];
    
    UILabel *portLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ipLabel.frame)+24, 60,21)];
    portLabel.text = @"端口号";
    portLabel.font = [UIFont systemFontOfSize:17];
    [contentView addSubview:portLabel];
    
    self.portText  = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(portLabel.frame)+4, CGRectGetMaxY(ipLabel.frame)+24, 200, 21)];
    self.portText.keyboardType = UIKeyboardTypeNumberPad;
    self.portText.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:self.portText];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((contentView.frame.size.width-80)/2, CGRectGetMaxY(self.portText.frame)+48, 80, 30);
    btn.layer.cornerRadius = 15;
    [btn setBackgroundColor: [UIColor systemBlueColor]];
    [btn setTitle:@"绑定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.connectCancelBlock) {
        self.connectCancelBlock();
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.ipText.text = _ip;
    self.portText.text = _port;
}
-(void)setContViewWithIp:(NSString*)ip port:(NSString*)port{
    if (ip.length && port.length) {
        _ip = ip;
        _port = port;
    }
}
@end
