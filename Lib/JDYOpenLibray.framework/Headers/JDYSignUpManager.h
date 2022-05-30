//
//  JDYSignUpManager.h
//  kdweibo
//
//  Created by LXL on 2022/3/8.
//  Copyright © 2022 www.kingdee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JDYLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDYSignUpManager : NSObject

+ (JDYSignUpManager *)shareSignUpManagerInstance;

//销毁
+(void)managerDealloc;


/*
 AppDelegate 方法didFinishLaunchingWithOptions 中调用
 调用代码：[JDYSignUpManager initLocationServiceWithApiKey:apiKey]
 **/
+(void)initLocationServiceWithApiKey:(NSString*)apiKey;

/**
 需要弹出签到界面的地方，由js桥【signUp】调用
 调用代码：
 [[JDYSignUpManager shareSignUpManagerInstance] showSignInWithLongitude:longitude.doubleValue latitude:latitude.doubleValue distance:distance.doubleValue callBack:^(BOOL isSignIn, JDYLocation *location) {
  
 }];
 */
-(void)showSignInWithLongitude:(double)longitude
                      latitude:(double)latitude
                      distance:(double)distance
                         title:(NSString*)title
                      callBack:(void(^)(BOOL isSignIn,JDYLocation *location))callBack;



/*签到取消由js桥【signCancel】之后调用
调用代码：
 [[JDYSignUpManager shareSignUpManagerInstance]signCancelsignCancelWithCallBack:^(){
 
 }];
 **/
-(void)signCancelWithCallBack:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
