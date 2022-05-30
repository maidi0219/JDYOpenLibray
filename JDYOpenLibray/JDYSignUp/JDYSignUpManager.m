//
//  JDYSignUpManager.m
//  kdweibo
//
//  Created by LXL on 2022/3/8.
//  Copyright © 2022 www.kingdee.com. All rights reserved.
//

#import "JDYSignUpManager.h"
#import "JDYSignUpViewController.h"

#define Success                @"success"
#define ErrorMessage           @"error"
#define ErrorCode              @"errorCode"
#define Data                   @"data"

@interface JDYSignUpManager ()
@property (nonatomic,strong) JDYSignUpViewController *signInVc;

@property (nonatomic,strong) UIView *parentView;//父view

@property(nonatomic,copy) void (^managerCallBack)(BOOL isSignIn,JDYLocation *location);
@end

@implementation JDYSignUpManager
static JDYSignUpManager *_instance;

-(void)dealloc{
    NSLog(@"----JDYSignUpManager销毁---");
}

+(void)managerDealloc{
    _instance = nil;
}

+ (JDYSignUpManager *)shareSignUpManagerInstance {
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        _instance = [[JDYSignUpManager alloc] init];
//    });
    if (!_instance) {
        _instance = [[JDYSignUpManager alloc] init];
    }
    return _instance;
}

+(void)initLocationServiceWithApiKey:(NSString*)apiKey {
    [AMapServices sharedServices].apiKey = apiKey;
}

-(void)showSignInWithLongitude:(double)longitude
                      latitude:(double)latitude
                      distance:(double)distance
                         title:(NSString*)title
                      callBack:(void(^)(BOOL isSignIn,JDYLocation *location))callBack{
    
    __weak typeof(self) wkSelf = self;
    self.signInVc = [[JDYSignUpViewController alloc]
                     initWithLongitude:longitude
                     latitude:latitude
                     title:title
                     distance:distance
                     callBack:^(BOOL isSignIn, JDYLocation *location) {
        if(!isSignIn){
            wkSelf.signInVc = nil;//需要销毁签到Vc
        }
        if(callBack){
            callBack(isSignIn,location);
        }
//        [wkSelf setupDicWithDic:dic isSignIn:isSignIn];
    }];
    [self.signInVc show];
    self.managerCallBack = callBack;
}


//-(void)setupDicWithDic:(NSDictionary*)dic isSignIn:(BOOL) isSignIn{
//    NSString*jsonStr = @"";
//       if (isSignIn) {
//           NSDictionary *resultDic = @{Success : @"true",ErrorCode : @"0", Data : dic};
//           jsonStr= [self dicChangeToJsonString:resultDic];
//       }else{
//           NSDictionary *resultDic = @{Success : @"false",ErrorMessage : @"取消打卡", Data : @{}};
//           jsonStr= [self dicChangeToJsonString:resultDic];
//           self.signInVc = nil;//需要
//       }
//        NSLog(@"返回参数jsonStr=%@",jsonStr);
//       if(jsonStr){
//           if (self.managerCallBack) {
//               self.managerCallBack(YES,jsonStr);
//           }
//       }
//}


//-(NSString *)dicChangeToJsonString:(NSDictionary*)dic{
//    if(dic){
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *resultArrayString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        [resultArrayString stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
//        return resultArrayString;
//    }
//    return @"";
//
//}

-(void)signCancelWithCallBack:(void(^)(void))callBack{
    if (self.signInVc) {
        [self.signInVc hideWithOutCallback];
        self.signInVc = nil;
        if(callBack){
            callBack();
        }
    }
}
@end
