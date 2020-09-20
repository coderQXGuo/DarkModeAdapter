//
//  UIColor+Adapter.h
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Adapter)

/// adpter darkMode WithColorName
/// @param hexColorName hexColorName
+ (UIColor *)colorAdpterWithHexColorName:(NSString *)hexColorName;

/// adpter darkMode WithColorName
/// @param hexColorName hexColorName
/// @param alpha alpha
+ (UIColor *)colorAdpterWithHexColorName:(NSString *)hexColorName
                                   alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
