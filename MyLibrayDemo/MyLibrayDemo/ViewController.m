//
//  ViewController.m
//  MyLibrayDemo
//
//  Created by LXL on 2022/3/11.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "ViewController.h"
//#import <JDYOpenLibray/JDYOpenLibray.h>//包含签到、打印
//#import <JDYPrinter/JDYPrinter.h>//打印单独的库
#import "JDYBillPrintManager.h"

@interface ViewController ()
//@property(nonatomic,strong) JDYSignUpManager *signUpManager;
@end

@implementation ViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:CGRectMake(100, 100, 100, 100)];
//    [btn setTitle:@"签到" forState:UIControlStateNormal];
//    [btn setBackgroundColor: [UIColor blueColor]];
//    [btn addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(100, 210, 200, 50)];
    [btn2 setTitle:@"打印列表" forState:UIControlStateNormal];
    [btn2 setBackgroundColor: [UIColor blueColor]];
    [btn2 addTarget:self action:@selector(printVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake(100, 320, 200, 50)];
    [btn3 setTitle:@"打印数据" forState:UIControlStateNormal];
    [btn3 setBackgroundColor: [UIColor blueColor]];
    [btn3 addTarget:self action:@selector(printData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(100, 430, 200, 50)];
    [btn4 setTitle:@"本地缓存的打印机列表" forState:UIControlStateNormal];
    [btn4 setBackgroundColor: [UIColor blueColor]];
    [btn4 addTarget:self action:@selector(localPrintList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

}


-(void)printData{
   
    //    NSString *str = @"{\"data\":{\"traceId\": \"112454678787891\",\"printDeviceId\": \"2\",\"printInfo\": [{\"data\":\"1b401b331e1b43211c57011b6101B9E3B6ABB9DAD4C1C2B7C7C5D3D0CFDEB9ABCBBED1F8BBA4B7D6B9ABCBBE1c57000a1b451b6101CFFACADBB6A9B5A51b460a1b6100B5A5BAC53A585344442D32303232303332342D30303030322020202020202020BFAAB5A5C8D5C6DA3A323032322D30332D323420202020202020202020202020BFCDBBA7C3FBB3C63A3939393939390aCAD5BBF5C8CB3A20202020202020202020202020202020202020202020202020C1AACFB5CAD6BBFA3A202020202020202020202020\",\"times\":3 },{\"data\":\"1b61011d21111d21000a1b61011b2108CFFACADBB3F6BFE2B5A51b21000a0a1b6100B5A5BAC53A5853323032323034313230303030370a1b6100BFAAB5A5C8D5C6DA3A323032322D30342D31320a1b6100BFCDBBA7C3FBB3C63AB0A1B9FE0a1b6100CAD5BBF5C8CB3A4173640a1b6100C1AACFB5CAD6BBFA3A31353638393736343331360a1b6100CAD5BBF5B5D8D6B73AC4DAC3C9B9C5D7D4D6CEC7F8B6F5B6FBB6E0CBB9CAD0D2C1BDF0BBF4C2E5C6EC313130330a0aC9CCC6B72020202020CAFDC1BF20202020\",\"times\":2 }]}}";
    //旧的方法
//    [JDYBillPrintManager printDatasWithData:str succeedCallBack:^(NSString *traceId, NSString *printDeviceId) {
//
//    } failedCallBack:^(NSString *traceId, NSString *printDeviceId, int errCode,NSString *errMsg) {
//
//    }];
    
    
    //新的方法
    [JDYBillPrintManager printMutableDatasWithData:[self testData] succeedCallBack:^(NSString *traceId, NSString *printDeviceId) {
        
    } failedCallBack:^(NSString *traceId, NSString *printDeviceId, int errCode,NSString *errMsg) {
        
    }];
    
    return;
 
}

-(void)localPrintList{
    //获取deviceId为2的本地打印列表
    [JDYBillPrintManager getPrinterWithDeviceId:@"2" callBack:^(NSArray *printList) {
        
    }];
}

-(void)printVc{
    //type 可以传blueTooth、network
    [JDYBillPrintManager selectPrinterWitType:@"blueTooth" printDeviceId:@"2" selectCallBack:^(JDYBlueToothModel *blueToothModel) {
        NSLog(@"----blueTooth content name=%@----",blueToothModel.name);
    } cancelCallBack:^{
        NSLog(@"取消");
    }];
}

//printDeviceId不为空
-(NSString*)testData{
    return @"{\"data\":{\"traceId\": \"112454678787891\",\"printDeviceId\": \"2\",\"printInfo\": [{\"details\":[{\"data\":\"1b61011d2111c3c0d2f81d21000a1b61011b2108cffacadbb3f6bfe2b5a51b21000a0a1b6100b5a5bac53a584832303232303630373030320a1b6100bfaab5a5c8d5c6da3a323032322d30362d30370a1b6100bfcdbba7c3fbb3c63ab0b2c4c8ccd5b4c90a0ac9ccc6b720202020202020202020cafdc1bf20202020202020202020b5a5bcdb20202020202020202020bdf0b6ee0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a4c5330337cc9edcce5c8e93235306d6c0a2020202020202020202020202020312e3030202020202020202020203131312e303020202020202020203131312e30300a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0abacfbcc620202020202020202020312e30302020202020202020202020202020202020202020202020203131312e303020202020202020200a0a1b6100cad5bfeebacfbcc63a0a1b6100b4f2d3a1cab1bce43a323032322d30362d30372031353a32323a33360a1b6100cad5bbf5b5a5cebbc7a9d5c23a0a1b6100c7a9d7d63a0a0a1b6101bdf0b5fbbeabb6b7d4c6cce1b9a9bcbccaf5d6a7b3d60a0a0a\",\"dataType\":\"text\",\"encryptionType\":\"hex\",\"size\":0}],\"times\":1 }]}}";
    
}

//printDeviceId为空时候返回printer【兼容零售端数据】
-(NSString*)testData2{
    return @"{\"data\":{\"traceId\": \"112454678787891\",\"printer\": {  \"address\":\"\",\"name\":\"\",\"printDeviceId\":\"\",\"type\":\"network\",\"networkIp\":\"172.20.155.124\",\"networkPort\":\"9100\",},\"printInfo\": [{\"details\":[{\"data\":\"1b61011d2111c3c0d2f81d21000a1b61011b2108cffacadbb3f6bfe2b5a51b21000a0a1b6100b5a5bac53a584832303232303630373030320a1b6100bfaab5a5c8d5c6da3a323032322d30362d30370a1b6100bfcdbba7c3fbb3c63ab0b2c4c8ccd5b4c90a0ac9ccc6b720202020202020202020cafdc1bf20202020202020202020b5a5bcdb20202020202020202020bdf0b6ee0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a4c5330337cc9edcce5c8e93235306d6c0a2020202020202020202020202020312e3030202020202020202020203131312e303020202020202020203131312e30300a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0abacfbcc620202020202020202020312e30302020202020202020202020202020202020202020202020203131312e303020202020202020200a0a1b6100cad5bfeebacfbcc63a0a1b6100b4f2d3a1cab1bce43a323032322d30362d30372031353a32323a33360a1b6100cad5bbf5b5a5cebbc7a9d5c23a0a1b6100c7a9d7d63a0a0a1b6101bdf0b5fbbeabb6b7d4c6cce1b9a9bcbccaf5d6a7b3d60a0a0a\",\"dataType\":\"text\",\"encryptionType\":\"hex\",\"size\":0}],\"times\":2 },{\"details\":[{\"data\":\"EBQIAQMUAQYCCBtAGzIbTQAdIRHDxbXqz/rK29ChxrEo1ti08tOhKQodIQAbYQC1pbrFICAgICAgICAgICBNMDE5MzIwMjIwNTA1MDAwMQobYQC1pb7dwODQzSAgICAgICAgICAgICAgICDB48rbz/rK2wobYQEbMwAbKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobMhthABthAMjVxtogICAgICAgICAyMDIyLTA1LTA1IDE1OjA0OjQ0ChthAL/Nu6cgICAgICAgICAgICAgICAgICAgIMHjytu/zbunChthAMrV0vjUsSAgICAgICAgICAgICAgICAgICAgs8LFr8r3CiAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtChthARszABsqIXQB////////wAAAwAAAwAAAwAAAwAQAwAQAwAR/wAR/wARiwARmwAdvwAX7wARywBxiwBxiwAxiwATywAX7wAdvwARmwARmwAR/wAR/wAQAwAQAwAAAwAAAwAAHwAAGwB/2wBhmwBhmwBhmwBhnwBhjwBhgwBhgwBhnwBhnwBhmwBhmwB/mwB/mwAAHwAAHwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAP/wAJmwBJmwB5mwA5mwAZmwAJmwAP/wAP/wAJmwAZmwB5mwBpmwAJmwAP+wAP/wAAAwAAAwAAAwAAcwABwwAH/wA//wBwAwAAgwABgwADAwAGBwAMfwAYAwBwAwBgAwAwAwAYAwAMfwAGAwADAwABgwABAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwABgwABiwADCwAHjwAGiwAMiwAYiwAwiwBgjwDg/wBgjwAwiwAYiwAMiwAGiwAHjwADCwADiwABgwABAwAAAwAcxwAZzwAXTwAWewBycwAycwAT8wATmwAfGwAYCwAj/wAj/wAiAwAmAwA+/wAiQwAiAwAiAwAj/wAgAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////ChsqIXQB////////AAwAAAwAAAwAAAwAAAwAAAwA/gwA/AwAAAwAAAwA8AwA+AwAMAwAMAwAMAwAMAwAMAwA8AwA5AwABgwABgwA/AwA/AwAAAwAAAwAAAwAAAwA/gwADAwACAwACAwACAwACAwA/gwA/AwAAAwAAAwA/gwA/AwACAwACAwACAwACAwA/AwA/gwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwBAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAQAwAQAwAQAwBQAwBQAwBQAwDQAwDQAwDQAwA/gwA/gwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAAAwBAAwDAAwD/gwC/gwCAAwDAAwDDgwBHAwA+AwAwAwAAAwAAAwAAAwBAAwDAAwD/gwCAAwDAAwDAAwBAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwADAwADAwADAwAzAwAbAwAPAwADAwADAwADAwA/AwADAwADAwADAwAPAwAbAwAzAwADAwADAwADAwAAAwAAAwAAAwB/AwB/AwBiAwDiAwDiAwDiAwA/AwAAAwABgwAxgwAzAwAGAwAcAwB4AwDMAwDGAwCGAwDzAwDBAwBAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwBAAwBAAwDAAwDAAwDAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwDAAwDAAwCAAwDAAwDAAwBAAwAAAwAAAwAAAwA////////ChsqIXQB////////AAAAAAAAAAAAAAAAAAAAGAYAfgMAfwMAwwMAw4MAwYMAwcMAwOcAwH4AADwAAAAAAAAAAAAA//8A//8AwMAAwMAAwMAAwMAAwMAA4YAAf4AAPwAAAAAAAAAAB/AAP/wAeB4AwAMAwAMAgAEAwAMAwAMAfB4AP/wAB+AAAAAAAcAAH/wAf/4A4AcAwAMAgAEAwAMAwAMAcA4AP/wAD/AAAAAAAAAAD/gAP/4AcA4AwAMAwAMAgAEAwAMA4AcAf/4AP/gAAAAAAAAAHgAAP4MAc4MAwMEAwMEAgMMAwMMA4YYAf/wAP/gAAwAAAAAAAAAAAAAA/wMA/wMAwwEAwwMAwwMAwYMAwc4AwPwAADAAAAAAAABgAAPAAA8AAHwAAeAAD4AAPgAA8AAAwAAAAAAAAYAAA4AAAwAABgAADgAAHAAAOAAAcAAA4AAAg//gw//g4AAAMAAAGAAADAAABgAABwAAAwAAA4AAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAAAwA//wA//wAAAwAAAwAAAwAAAAAAAAAAAAAAAwAAAwAAAgAAAAAAAAAf+AA//gAgBwAAAwAAAQAAAwAAAwAgBgA//AAf+AAAAAAAAAAH8AA//AA4HgAAAwAAAwAAAQAAAwAAAwA8HgA//AAH4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAgAwA//wA//wAAAwAAAwAAAwAAAAAAAAABwAAf/AA//gAgBwAAAwAAAQAAAwAAAwAwDgA//AAP8AAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAgAwA//wA//wAAAwAAAwAAAwAAAAAAAAABwAAf/AA//gAgBwAAAwAAAQAAAwAAAwAwDgA//AAP8AAAAAAAAAA////////ChsqIXQB////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwAAf/AB//ADgBADAAACAAADAAADAAABwDAA//AAP8AAAAAAAAAAP+AA//ABwDADAAADAAACAAADAAADgBAB//AA/+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////ChsqIXQB//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAgDAAwDAAwDAAQDAAwDAAwDAAgDAAADAAADAAADAAADAAADAAgDAAgDAAwDAAwDAAQDAAwDAAwDAAgDAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAChsyG2EAIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0KG2EA1dvHsL3wtu4gICAgICAgICAgICAgICAgICAgICAgMTAKG2EA1fu1pbTZz/rTxbvdICAgICAgICAgICAgICAgLTAuOTgKG2EA06bK1b3wtu4gICAgICAgICAgICAgICAgICAgIDkuMDIKG2EAveHL49XLu6cKG2EAYWHP1r3w1qe4tjEyMyAgICAgICAgICAgICCjpDkuMDIKChthAMrV0vi7+rHgusUgICAgICAgICAgICAgICAgICAwMTkzChthAMPFterD+7PGICAgICAgICAgICAgICAgICAguePW3bXqChthAMPFteq12Na3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgueO2q8qhuePW3crQxuTL/Mf4sKLLubXZt9IKG2EAwarPtbe9yr0gICAgICAgICAgICAgMTM2NTk4NzQ1ODcKG2EAwarPtcjLICAgICAgICAgICAgICAgICAgICCwosj4tcIKG2EAtPLTocqxvOQgICAgIDIwMjItMDUtMDUgMTU6MTE6MjMKICAgICAgICAgICAguavLvsu1w/cKCgoK\",\"dataType\":\"text\",\"encryptionType\":\"base64\",\"size\":0}],\"times\":1 }]}}";
    
}

-(void)signUpAction{
//    [[JDYSignUpManager shareSignUpManagerInstance]
//     showSignInWithLongitude:113.95523608961867
//     latitude:22.535187586030304
//     distance:250
//     title:@"门店打卡"
//     callBack:^(BOOL isSignIn, JDYLocation * _Nonnull location) {
//        if (!isSignIn) {//取消打卡之后销毁JDYSignUpManager
//            [JDYSignUpManager managerDealloc];
//        }
//    }];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self signCancel];
//    });
}

//签到成功后js桥调用
-(void)signCancel{
//    [[JDYSignUpManager shareSignUpManagerInstance] signCancelWithCallBack:^{
//        //打卡之后成功之后销毁JDYSignUpManager
//        [JDYSignUpManager managerDealloc];
//    }];
}
@end
