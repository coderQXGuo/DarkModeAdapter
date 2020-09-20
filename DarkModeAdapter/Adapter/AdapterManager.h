//
//  AdapterManager.h
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdapterManager : NSObject

///current darkModeStyle
@property (nonatomic, readonly,getter=isDarkModeStyle) BOOL darkModeStyle;

/// default is YES, if YES will show light; if NO will follow system mode;
@property(nonatomic, assign) BOOL shouldFollowSystemMode;

/// darkModeManger
+ (instancetype)sharedInstance;

/// destroy manager
+ (void )destroySharedInstance;


- (instancetype)init __attribute__((unavailable("Disabled !!! Please Use +sharedInstance instead")));


/// Config the colors
/// @param bundleName resource bundle name
- (void)configDarkModeColorBundleName:(NSString *)bundleName;

/// Gets the color value based on the color name
/// @param colorName color name
- (NSString *)colorHexStringWithColorName:(NSString *)colorName;

/// Get the corresponding alpha according to the color name
/// @param colorName color name
- (float)colorAlphaWithColorName:(NSString *)colorName;

@end

NS_ASSUME_NONNULL_END
