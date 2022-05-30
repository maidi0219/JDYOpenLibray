//
//  JDYSignUpViewController.h
//  kdweibo
//
//  Created by Jacy Lee on 2021/12/13.
//  Copyright © 2021 www.kingdee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JDYLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDYSignUpViewController : UIViewController

-(instancetype)initWithLongitude:(double)longitude
                        latitude:(double)latitude
                           title:(NSString*)title
                        distance:(double)distance
                        callBack:(void(^)(BOOL isSignIn,JDYLocation *location))callBack;

- (void)show;

- (void)showInView:(UIView*)view;


- (void)hideWithOutCallback;
@end

NS_ASSUME_NONNULL_END
