//
//  ViewController.m
//  MyLibrayDemo
//
//  Created by LXL on 2022/3/11.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "ViewController.h"
//#import <JDYOpenLibray/JDYOpenLibray.h>


//#import <JDYPrinter/JDYPrinter.h>
#import "JDYBillPrintManager.h"
#define HISUNPLUGIN_BUNDLE_NAME @"JDYOpenLibrayBundle.bundle"

#define HISUNPLUGIN_BUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: HISUNPLUGIN_BUNDLE_NAME]

#define HISUNPLUGIN_MYBUNDLE [NSBundle bundleWithPath: HISUNPLUGIN_BUNDLE_PATH]

@interface ViewController ()
//@property(nonatomic,strong) JDYSignUpManager *signUpManager;
@property(nonatomic,strong) UIButton *printBtn;

@end

@implementation ViewController{
    
}

- (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setBackgroundColor: [UIColor blueColor]];
    [btn addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(100, 210, 100, 100)];
    [btn2 setTitle:@"打印列表" forState:UIControlStateNormal];
    [btn2 setBackgroundColor: [UIColor blueColor]];
    [btn2 addTarget:self action:@selector(printVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.printBtn = btn2;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake(100, 320, 100, 100)];
    [btn3 setTitle:@"打印数据" forState:UIControlStateNormal];
    [btn3 setBackgroundColor: [UIColor blueColor]];
    [btn3 addTarget:self action:@selector(printData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(100, 430, 100, 100)];
    [btn4 setTitle:@"本地打印机" forState:UIControlStateNormal];
    [btn4 setBackgroundColor: [UIColor blueColor]];
    [btn4 addTarget:self action:@selector(printData2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

}
-(NSString*)testData{
    return @"1b61011d21111d21000a1b61011b2108CFFACADBB3F6BFE2B5A51b21000a0a1b6100B5A5BAC53A5853323032323034313230303030370a1b6100BFAAB5A5C8D5C6DA3A323032322D30342D31320a1b6100BFCDBBA7C3FBB3C63AB0A1B9FE0a1b6100CAD5BBF5C8CB3A4173640a1b6100C1AACFB5CAD6BBFA3A31353638393736343331360a1b6100CAD5BBF5B5D8D6B73AC4DAC3C9B9C5D7D4D6CEC7F8B6F5B6FBB6E0CBB9CAD0D2C1BDF0BBF4C2E5C6EC313130330a0aC9CCC6B72020202020CAFDC1BF2020202020B5A5BCDB2020202020BDF0B6EE0a2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D0a4132303139303030327C3635363536357CBAC0BBAAC9B3B7A22BB6E0B5A5CEBBA3A8CED2CAC7C3FBD7D6BADCB3A4B5C4C9CCC6B7B9FEB9FEB9FEB9FEB9FEBAC7BAC7BAC7BAC7A3A97C5BB9FEB9FEB9FEB9FE6661666166610a202020202020202020312E30302020202020313230302E30302020313230302E30300a2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D0aBACFBCC62020202020312E30302020202020202020202020202020313230302E303020200a0a1b6100D5FBB5A5D3C5BBDD3A302E30300a1b6100CFFACADBB7D1D3C33A0a1b6100D3C5BBDDBAF3BDF0B6EE3A313430342E30300a1b6100BFCDBBA7B3D0B5A3B7D1D3C33A300a1b6100CAD5BFEEBACFBCC63A0a1b6100B1BEB5A5CEB4CAD53A313430342E30300a1b6100C0DBBCC6C7B7BFEE3A2A2A2A0a1b6100CFFACADBC8CBD4B13A0a1b6100B1B8D7A23A0a1b6100B4F2D3A1CAB1BCE43A323032322D30342D31322031373A31303A33310a1b6100B4F2D3A1D2B3C2EB3A0a1b6100CAD5BBF5B5A5CEBBC7A9D5C23A0a0a1b6101BDF0B5FBBEABB6B7D4C6CCE1B9A9BCBCCAF5D6A7B3D60a0a0a";
}
-(void)printData{
   
//    NSArray *datas = @[[self dataWithHexString:data]];
//    [[SEPrinterManager sharedInstance] sendPrintDatas:datas completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
//        if (error.length>0) {
//            NSLog(@"error = %@",error);
//        }else{
//
//        }
//    }];
    NSString *str = @"{\"data\":{\"traceId\": \"112454678787891\",\"printDeviceId\": \"2\",\"printInfo\": [{\"data\":\"1b401b331e1b43211c57011b6101B9E3B6ABB9DAD4C1C2B7C7C5D3D0CFDEB9ABCBBED1F8BBA4B7D6B9ABCBBE1c57000a1b451b6101CFFACADBB6A9B5A51b460a1b6100B5A5BAC53A585344442D32303232303332342D30303030322020202020202020BFAAB5A5C8D5C6DA3A323032322D30332D323420202020202020202020202020BFCDBBA7C3FBB3C63A3939393939390aCAD5BBF5C8CB3A20202020202020202020202020202020202020202020202020C1AACFB5CAD6BBFA3A202020202020202020202020\",\"times\":3 },{\"data\":\"1b61011d21111d21000a1b61011b2108CFFACADBB3F6BFE2B5A51b21000a0a1b6100B5A5BAC53A5853323032323034313230303030370a1b6100BFAAB5A5C8D5C6DA3A323032322D30342D31320a1b6100BFCDBBA7C3FBB3C63AB0A1B9FE0a1b6100CAD5BBF5C8CB3A4173640a1b6100C1AACFB5CAD6BBFA3A31353638393736343331360a1b6100CAD5BBF5B5D8D6B73AC4DAC3C9B9C5D7D4D6CEC7F8B6F5B6FBB6E0CBB9CAD0D2C1BDF0BBF4C2E5C6EC313130330a0aC9CCC6B72020202020CAFDC1BF20202020\",\"times\":2 }]}}";
    //旧的方法
//    [JDYBillPrintManager printDatasWithData:str succeedCallBack:^(NSString *traceId, NSString *printDeviceId) {
//
//    } failedCallBack:^(NSString *traceId, NSString *printDeviceId, int errCode,NSString *errMsg) {
//
//    }];
    
    
    
    NSString *str2 = @"{\"data\":{\"traceId\": \"112454678787891\",\"printDeviceId\": \"2\",\"printInfo\": [{\"details\":[{\"data\":\"1b401b331e1b43211c57011b6101B9E3B6ABB9DAD4C1C2B7C7C5D3D0CFDEB9ABCBBED1F8BBA4B7D6B9ABCBBE1c57000a1b451b6101CFFACADBB6A9B5A51b460a1b6100B5A5BAC53A585344442D32303232303332342D30303030322020202020202020BFAAB5A5C8D5C6DA3A323032322D30332D323420202020202020202020202020BFCDBBA7C3FBB3C63A3939393939390aCAD5BBF5C8CB3A20202020202020202020202020202020202020202020202020C1AACFB5CAD6BBFA3A202020202020202020202020\",\"dataType\":\"text\",\"encryptionType\":\"hex\",\"size\":0}],\"times\":1 },{\"details\":[{\"data\":\"EBQIAQMUAQYCCBtAGzIbTQAdIRHDxbXqz/rK29ChxrEo1ti08tOhKQodIQAbYQC1pbrFICAgICAgICAgICBNMDE5MzIwMjIwNTA1MDAwMQobYQC1pb7dwODQzSAgICAgICAgICAgICAgICDB48rbz/rK2wobYQEbMwAbKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobKiFoAf///////////////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////////////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////////////wAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAP///////////wAAAAAAAAAAAAAAAAAAAP///////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////wAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////////////////////////////wAAAAAAAP///////////wAAAAAAAP///////////////////wobMhthABthAMjVxtogICAgICAgICAyMDIyLTA1LTA1IDE1OjA0OjQ0ChthAL/Nu6cgICAgICAgICAgICAgICAgICAgIMHjytu/zbunChthAMrV0vjUsSAgICAgICAgICAgICAgICAgICAgs8LFr8r3CiAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtChthARszABsqIXQB////////wAAAwAAAwAAAwAAAwAQAwAQAwAR/wAR/wARiwARmwAdvwAX7wARywBxiwBxiwAxiwATywAX7wAdvwARmwARmwAR/wAR/wAQAwAQAwAAAwAAAwAAHwAAGwB/2wBhmwBhmwBhmwBhnwBhjwBhgwBhgwBhnwBhnwBhmwBhmwB/mwB/mwAAHwAAHwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAP/wAJmwBJmwB5mwA5mwAZmwAJmwAP/wAP/wAJmwAZmwB5mwBpmwAJmwAP+wAP/wAAAwAAAwAAAwAAcwABwwAH/wA//wBwAwAAgwABgwADAwAGBwAMfwAYAwBwAwBgAwAwAwAYAwAMfwAGAwADAwABgwABAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwABgwABiwADCwAHjwAGiwAMiwAYiwAwiwBgjwDg/wBgjwAwiwAYiwAMiwAGiwAHjwADCwADiwABgwABAwAAAwAcxwAZzwAXTwAWewBycwAycwAT8wATmwAfGwAYCwAj/wAj/wAiAwAmAwA+/wAiQwAiAwAiAwAj/wAgAwAAAwAAAwAAAwAAAwAAAwAAA////////wAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAA////////ChsqIXQB////////AAwAAAwAAAwAAAwAAAwAAAwA/gwA/AwAAAwAAAwA8AwA+AwAMAwAMAwAMAwAMAwAMAwA8AwA5AwABgwABgwA/AwA/AwAAAwAAAwAAAwAAAwA/gwADAwACAwACAwACAwACAwA/gwA/AwAAAwAAAwA/gwA/AwACAwACAwACAwACAwA/AwA/gwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwBAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAQAwAQAwAQAwBQAwBQAwBQAwDQAwDQAwDQAwA/gwA/gwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAQAwAAAwBAAwDAAwD/gwC/gwCAAwDAAwDDgwBHAwA+AwAwAwAAAwAAAwAAAwBAAwDAAwD/gwCAAwDAAwDAAwBAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwADAwADAwADAwAzAwAbAwAPAwADAwADAwADAwA/AwADAwADAwADAwAPAwAbAwAzAwADAwADAwADAwAAAwAAAwAAAwB/AwB/AwBiAwDiAwDiAwDiAwA/AwAAAwABgwAxgwAzAwAGAwAcAwB4AwDMAwDGAwCGAwDzAwDBAwBAAwAAAwAAAwAAAwAAAwAAAwA////////AAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwBAAwBAAwDAAwDAAwDAAwAAAwAAAwAAAwAAAwAAAwAAAwAAAwBAAwDAAwDAAwCAAwDAAwDAAwBAAwAAAwAAAwAAAwA////////ChsqIXQB////////AAAAAAAAAAAAAAAAAAAAGAYAfgMAfwMAwwMAw4MAwYMAwcMAwOcAwH4AADwAAAAAAAAAAAAA//8A//8AwMAAwMAAwMAAwMAAwMAA4YAAf4AAPwAAAAAAAAAAB/AAP/wAeB4AwAMAwAMAgAEAwAMAwAMAfB4AP/wAB+AAAAAAAcAAH/wAf/4A4AcAwAMAgAEAwAMAwAMAcA4AP/wAD/AAAAAAAAAAD/gAP/4AcA4AwAMAwAMAgAEAwAMA4AcAf/4AP/gAAAAAAAAAHgAAP4MAc4MAwMEAwMEAgMMAwMMA4YYAf/wAP/gAAwAAAAAAAAAAAAAA/wMA/wMAwwEAwwMAwwMAwYMAwc4AwPwAADAAAAAAAABgAAPAAA8AAHwAAeAAD4AAPgAA8AAAwAAAAAAAAYAAA4AAAwAABgAADgAAHAAAOAAAcAAA4AAAg//gw//g4AAAMAAAGAAADAAABgAABwAAAwAAA4AAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAAAwA//wA//wAAAwAAAwAAAwAAAAAAAAAAAAAAAwAAAwAAAgAAAAAAAAAf+AA//gAgBwAAAwAAAQAAAwAAAwAgBgA//AAf+AAAAAAAAAAH8AA//AA4HgAAAwAAAwAAAQAAAwAAAwA8HgA//AAH4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAgAwA//wA//wAAAwAAAwAAAwAAAAAAAAABwAAf/AA//gAgBwAAAwAAAQAAAwAAAwAwDgA//AAP8AAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAwAgAwAAAwAgAwA//wA//wAAAwAAAwAAAwAAAAAAAAABwAAf/AA//gAgBwAAAwAAAQAAAwAAAwAwDgA//AAP8AAAAAAAAAA////////ChsqIXQB////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwAAf/AB//ADgBADAAACAAADAAADAAABwDAA//AAP8AAAAAAAAAAP+AA//ABwDADAAADAAACAAADAAADgBAB//AA/+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////////ChsqIXQB//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAgDAAwDAAwDAAQDAAwDAAwDAAgDAAADAAADAAADAAADAAADAAgDAAgDAAwDAAwDAAQDAAwDAAwDAAgDAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAAADAA//AA//AAChsyG2EAIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0KG2EA1dvHsL3wtu4gICAgICAgICAgICAgICAgICAgICAgMTAKG2EA1fu1pbTZz/rTxbvdICAgICAgICAgICAgICAgLTAuOTgKG2EA06bK1b3wtu4gICAgICAgICAgICAgICAgICAgIDkuMDIKG2EAveHL49XLu6cKG2EAYWHP1r3w1qe4tjEyMyAgICAgICAgICAgICCjpDkuMDIKChthAMrV0vi7+rHgusUgICAgICAgICAgICAgICAgICAwMTkzChthAMPFterD+7PGICAgICAgICAgICAgICAgICAguePW3bXqChthAMPFteq12Na3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgueO2q8qhuePW3crQxuTL/Mf4sKLLubXZt9IKG2EAwarPtbe9yr0gICAgICAgICAgICAgMTM2NTk4NzQ1ODcKG2EAwarPtcjLICAgICAgICAgICAgICAgICAgICCwosj4tcIKG2EAtPLTocqxvOQgICAgIDIwMjItMDUtMDUgMTU6MTE6MjMKICAgICAgICAgICAguavLvsu1w/cKCgoK\",\"dataType\":\"text\",\"encryptionType\":\"base64\",\"size\":0}],\"times\":1 }]}}";
    
    //新的方法
    [JDYBillPrintManager printMutableDatasWithData:str2 succeedCallBack:^(NSString *traceId, NSString *printDeviceId) {
        
    } failedCallBack:^(NSString *traceId, NSString *printDeviceId, int errCode,NSString *errMsg) {
        
    }];
    
    
    return;
 
}

-(void)printData2{
    [JDYBillPrintManager getPrinterWithDeviceId:@"2" callBack:^(NSArray *printList) {
        
    }];
}
/**
 *    @brief    将字符表示的16进制数转化为二进制数据
 *
 *    @param     hexString     字符表示的16进制数，长度必须为偶数
 *
 *    @return    二进制数据
 */
- (NSData *)dataWithHexString:(NSString *)hexString{
    if (hexString.length ==0) return nil;
    // hexString的长度应为偶数
    if ([hexString length] % 2 != 0)
        return nil;
    
    NSUInteger len = [hexString length];
    NSMutableData *retData = [[NSMutableData alloc] init];
    const char *ch = [[hexString dataUsingEncoding:NSASCIIStringEncoding] bytes];
    for (int i=0 ; i<len ; i+=2) {
        
        int height=0;
        if (ch[i]>='0' && ch[i]<='9')
            height = ch[i] - '0';
        else if (ch[i]>='A' && ch[i]<='F')
            height = ch[i] - 'A' + 10;
        else if (ch[i]>='a' && ch[i]<='f')
            height = ch[i] - 'a' + 10;
        else
            // 错误数据
            return nil;
        
        int low=0;
        if (ch[i+1]>='0' && ch[i+1]<='9')
            low = ch[i+1] - '0';
        else if (ch[i+1]>='A' && ch[i+1]<='F')
            low = ch[i+1] - 'A' + 10;
        else if (ch[i+1]>='a' && ch[i+1]<='f')
            low = ch[i+1] - 'a' + 10;
        else
            // 错误数据
            return nil;
        
        int byteValue = height*16 + low;
        [retData appendBytes:&byteValue length:1];
    }
    
    return retData;
}
-(void)printVc{
    
    [JDYBillPrintManager selectPrinterWitType:@"bluetooth" printDeviceId:@"2" selectCallBack:^(JDYBlueToothModel *blueToothModel) {
        NSLog(@"----blueTooth content name=%@----",blueToothModel.name);
    } cancelCallBack:^{
        NSLog(@"取消");
    }];
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
