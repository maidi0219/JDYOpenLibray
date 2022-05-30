//
//  UIImage+JDY.h
//  JDYOpenLibray
//
//  Created by LXL on 2022/3/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JDY)
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle;
@end

NS_ASSUME_NONNULL_END
