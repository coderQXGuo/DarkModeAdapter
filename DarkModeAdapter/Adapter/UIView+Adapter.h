//
//  UIView+Adapter.h
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Here you can expand the properties you want
@interface UIView (Adapter)

/// Config CaLayer BorderColor use Hex String
@property(nonatomic, copy) NSString *layerBorderColorHex;

/// Config CaLayer BackgroundColor use Hex String
@property(nonatomic, copy) NSString *layerBackgroundColorHex;

/// Config CaLayer ShadowColor use Hex String
@property(nonatomic, copy) NSString *layerShadowColorHex;

@end

NS_ASSUME_NONNULL_END
