//
//  UIColor+JDY.h
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRGB:rgbValue]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRGB:rgbValue alpha:alphaValue]

@interface UIColor (JDY)

+ (UIColor *)kdTextColor1;//primary
+ (UIColor *)kdTextColor2;//secondary
+ (UIColor *)kdTextColor3;//disable
+ (UIColor *)kdTextColor4;//caution
+ (UIColor *)kdTextColor5;//guide
+ (UIColor *)kdTextColor6;//primary light
+ (UIColor *)kdTextColor6_half; //登陆
+ (UIColor *)kdTextColor7;//press
+ (UIColor *)kdTextColor8;//keyword normal
+ (UIColor *)kdTextColor9;//keyword press
+ (UIColor *)kdTextColor10;//banner
+ (UIColor *)kdTextColor11;


+ (UIColor *)kdBackgroundColor1;    /**< EAEFF3 */
+ (UIColor *)kdBackgroundColor2;    /**< FFFFFF */
+ (UIColor *)kdBackgroundColor3;    /**< E7E9EB */
+ (UIColor *)kdBackgroundColor4;    /**< FEEEEE */
+ (UIColor *)kdBackgroundColor5;    /**< 04142A */
+ (UIColor *)kdBackgroundColor6;    /**< F7F9FA v8下所有列表cell的背景色 */
+ (UIColor *)kdBackgroundColor7;    /**< F1F4F8 */
+ (UIColor *)kdDividingLineColor;
+ (UIColor *)kdSubtitleColor;

+ (UIColor *)kdPopupColor;
+ (UIColor *)kdPopupBackgroundColor;

+ (UIColor *)kdButtonHightColor;
+ (UIColor *)kdQRScanMaskColor;

+ (UIColor *)colorWithRGB:(int)rgbValue;
+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;

+ (UIColor *)kdNavYellowColor;

+ (UIColor *)kdBlackColor;//十分之一的纯黑

@end
