//
//  UIColor+Adapter.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "UIColor+Adapter.h"
#import "NSString+Adapter.h"
#import "AdapterManager.h"

@implementation UIColor (Adapter)

+ (UIColor *)colorAdpterWithHexColorName:(NSString *)hexColorName
                                   alpha:(CGFloat)alpha {
    
    if (isEmptyString(hexColorName)) {
        return nil;
    }
   
    if (@available(iOS 13.0,*)) {
        UIColor *currentShowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            NSString *hexString = [[AdapterManager sharedInstance] colorHexStringWithColorName:hexColorName];
            return [UIColor colorFromHexString:hexString alpha:alpha];
        }];
        return currentShowColor;
    } else {
        NSString *hexString = [[AdapterManager sharedInstance] colorHexStringWithColorName:hexColorName];
        return [UIColor colorFromHexString:hexString alpha:alpha];
    }
}

+ (UIColor *)colorAdpterWithHexColorName:(NSString *)hexColorName {
    float alpha = [[AdapterManager sharedInstance] colorAlphaWithColorName:hexColorName];
    return [self colorAdpterWithHexColorName:hexColorName alpha:alpha];
}

+ (UIColor *)colorFromHexString:(NSString *)colorHexStr
                              alpha:(CGFloat)alpha {
    
    NSString *cString = [[colorHexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // r
    NSString *rString = [cString substringWithRange:range];
    
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
