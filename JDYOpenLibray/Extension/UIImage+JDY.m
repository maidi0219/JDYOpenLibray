//
//  UIImage+JDY.m
//  JDYOpenLibray
//
//  Created by LXL on 2022/3/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "UIImage+JDY.h"

@implementation UIImage (JDY)
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

@end
