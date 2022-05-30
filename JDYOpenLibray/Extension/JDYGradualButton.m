//
//  UIButton+JDYGradualButton.m
//  JDYOpenLibray
//
//  Created by LXL on 2022/3/13.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import "JDYGradualButton.h"
#import "UIColor+JDY.h"
@interface JDYGradualButton()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation JDYGradualButton
- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_gradientLayer];
        
        _gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRGB:0x3CBAFF].CGColor,(__bridge id)[UIColor colorWithRGB:0x5C92FF].CGColor];
        
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        
    }
    return _gradientLayer;
}
- (UIColor *)colorWithRGB:(int)rgbValue  {
    return [UIColor colorWithRed:((float) (((rgbValue) & 0xFF0000) >> 16)) / 255.0
                           green:((float) (((rgbValue) & 0x00FF00) >> 8)) / 255.0
                            blue:((float) ((rgbValue) & 0x0000FF)) / 255.0
                           alpha:1];
}


+ (instancetype)buttonWithType: (UIButtonType)buttonType
                    startColor: (UIColor *)startColor
                      endColor: (UIColor *)endColor
                     colorType: (JDYGradualButtonColorType)colorType {
    JDYGradualButton *button = [JDYGradualButton buttonWithType:buttonType];
    button.gradientLayer = [CAGradientLayer layer];
    button.gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    switch (colorType) {
        case JDYGradualButtonColorTypeH: {
            button.gradientLayer.startPoint = CGPointMake(0, 0);
            button.gradientLayer.endPoint = CGPointMake(1.0, 0);
        }
            break;
        case JDYGradualButtonColorTypeV: {
            button.gradientLayer.startPoint = CGPointMake(0, 0);
            button.gradientLayer.endPoint = CGPointMake(0, 1.0);
        }
            break;
            
        default:
            break;
    }
    [button.layer addSublayer:button.gradientLayer];
    return button;
}

+ (instancetype)buttonWithType: (UIButtonType)buttonType
                     colorType: (JDYGradualButtonColorType)colorType {
    JDYGradualButton *button = [JDYGradualButton buttonWithType:buttonType];
    button.gradientLayer = [CAGradientLayer layer];
    switch (colorType) {
        case JDYGradualButtonColorTypeH: {
            button.gradientLayer.startPoint = CGPointMake(0, 0);
            button.gradientLayer.endPoint = CGPointMake(1.0, 0);
        }
            break;
        case JDYGradualButtonColorTypeV: {
            button.gradientLayer.startPoint = CGPointMake(0, 0);
            button.gradientLayer.endPoint = CGPointMake(0, 1.0);
        }
            break;
            
        default:
            break;
    }
    [button.layer addSublayer:button.gradientLayer];
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

- (void)setStartColor: (UIColor*)startColor endColor: (UIColor*)endColor {
    self.gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
}

@end
