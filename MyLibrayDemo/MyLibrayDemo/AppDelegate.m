//
//  AppDelegate.m
//  MyLibrayDemo
//
//  Created by LXL on 2022/3/11.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "AppDelegate.h"
//#import <JDYOpenLibray/JDYOpenLibray.h>
//#import "JDYSignUpManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
 @synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [JDYSignUpManager initLocationServiceWithApiKey:@"f137c53e8ad06206a9df3ccc3aa0cc6b"];

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
