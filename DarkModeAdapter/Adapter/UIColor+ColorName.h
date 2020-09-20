//
//  UIColor+ColorName.h
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ColorName)

+ (instancetype)qx_colorNamed:(NSString *)colorName;

@end

NS_ASSUME_NONNULL_END
