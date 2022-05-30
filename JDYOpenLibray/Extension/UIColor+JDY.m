//
//  UIColor+JDY.m
//


#import "UIColor+JDY.h"

@implementation UIColor (JDY)

+ (UIColor *)kdTextColor1 {
    return [self colorWithRGB:0x030303];
}

+ (UIColor *)kdTextColor2 {
    return [self colorWithRGB:0x98A1A8];
}

+ (UIColor *)kdTextColor3 {
    return [self colorWithRGB:0xC2CBD0];
}

+ (UIColor *)kdTextColor4 {
    return [self colorWithRGB:0xF35959];
}

+ (UIColor *)kdTextColor5 {
    return [self colorWithRGB:0x3CBAFF];
}

+ (UIColor *)kdTextColor6 {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)kdTextColor6_half {
    return [UIColor colorWithRGB:0xFFFFFF
                           alpha:0.5f];
}

+ (UIColor *)kdTextColor7 {
    return [self colorWithRGB:0x308EC2];
}

+ (UIColor *)kdTextColor8 {
    return [self colorWithRGB:0x95D10E];
}

+ (UIColor *)kdTextColor9 {
    return [self colorWithRGB:0xFD6691];
}

+ (UIColor *)kdTextColor10 {
    return [self colorWithRGB:0x31D2EA];
}

+ (UIColor *)kdTextColor11 {
    return [self colorWithRGB:0x5D6972];
}

+ (UIColor *)kdBackgroundColor1 {
    return [self colorWithRGB:0xEAEFF3];
}

+ (UIColor *)kdBackgroundColor2 {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)kdBackgroundColor3 {
    return [self colorWithRGB:0xE7E9EB];
}

+ (UIColor *)kdBackgroundColor4 {
    return [self colorWithRGB:0xFEEEEE];
}

+ (UIColor *)kdBackgroundColor5 {
    return [self colorWithRGB:0x04142A];
}

+ (UIColor *)kdBackgroundColor6 {
    return [self colorWithRGB:0xF7F9FA];
}

+ (UIColor *)kdBackgroundColor7 {
    return [self colorWithRGB:0xF1F4F8];
}

+ (UIColor *)kdDividingLineColor {
    return [self colorWithRGB:0xEAEFF3];
}

+ (UIColor *)kdSubtitleColor {
    return [self colorWithRGB:0xF3F5F9];
}

+ (UIColor *)kdPopupColor {
    return [self colorWithRGB:0x04142A alpha:0.75];
}

+ (UIColor *)kdPopupBackgroundColor {
    return [self colorWithRGB:0x04142A alpha:0.3];
}

+ (UIColor *)kdNavYellowColor {
    return [self colorWithRGB:0xF7BF28];
}

+ (UIColor *)kdButtonHightColor {
    return [self colorWithRGB:0xE8EEF0 alpha:0.3];
}

+ (UIColor *)kdQRScanMaskColor {
    return [self colorWithRGB:0x0C213F alpha:0.3];
}

+ (UIColor *)colorWithRGB:(int)rgbValue {
    return [UIColor colorWithRGB:rgbValue
                           alpha:1];
}

+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float) (((rgbValue) & 0xFF0000) >> 16)) / 255.0
                           green:((float) (((rgbValue) & 0x00FF00) >> 8)) / 255.0
                            blue:((float) ((rgbValue) & 0x0000FF)) / 255.0
                           alpha:alpha];
}


+ (UIColor *)colorWithHexRGB:(NSString *)inColorString
{
    
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:1.0];
    
    return result;
    
}


+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha {

    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:alpha];

    return result;

}


+ (UIColor *)kdBlackColor
{
    return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
}

@end
