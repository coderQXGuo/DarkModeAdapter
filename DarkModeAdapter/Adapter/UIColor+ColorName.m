//
//  UIColor+ColorName.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "UIColor+ColorName.h"
#import "AdapterManager.h"
#import "UIColor+Adapter.h"

@implementation UIColor (ColorName)

+ (instancetype)qx_colorNamed:(NSString *)colorName {
    if (colorName.length == 0) return [UIColor darkGrayColor];
    if (@available(iOS 11.0, *)) {
        UIColor *color = [UIColor colorNamed:colorName];
        if ([AdapterManager sharedInstance].shouldFollowSystemMode && color) {
            return color;
        }
    }
    return [UIColor colorAdpterWithHexColorName:colorName];
}

@end
