//
//  UIButton+JDYGradualButton.h
//  JDYOpenLibray
//
//  Created by LXL on 2022/3/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JDYGradualButtonColorTypeH, //横向渐变
    JDYGradualButtonColorTypeV //纵向渐变
} JDYGradualButtonColorType;


@interface JDYGradualButton:UIButton
+ (instancetype)buttonWithType: (UIButtonType)buttonType
                    startColor: (UIColor *)startColor
                      endColor: (UIColor *)endColor
                     colorType: (JDYGradualButtonColorType)colorType;

+ (instancetype)buttonWithType: (UIButtonType)buttonType
                     colorType: (JDYGradualButtonColorType)colorType;

- (void)setStartColor: (UIColor*)startColor endColor: (UIColor*)endColor;

@end

NS_ASSUME_NONNULL_END
