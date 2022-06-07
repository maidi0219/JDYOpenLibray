//
//  NetWorkPrintSettingViewController.h
//  MyLibrayDemo
//
//  Created by Jacy Lee on 2022/6/6.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkPrintSettingViewController : UIViewController

typedef void(^NetWorkFinidhedBlock)(NSString *ipStr, NSString *port);
typedef void(^NetWorkCancelBlock)(void);

@property(nonatomic)NetWorkCancelBlock connectCancelBlock;// 取消
@property(nonatomic)NetWorkFinidhedBlock connectFinishBlock;// 绑定完毕的回调
-(void)setContViewWithIp:(NSString*)ip port:(NSString*)port;
@end

NS_ASSUME_NONNULL_END
