//
//  AdapterManager.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "AdapterManager.h"
#import "NSString+Adapter.h"
#import <UIKit/UIKit.h>

@interface AdapterManager ()

@property (nonatomic, readwrite,getter=isDarkModeStyle) BOOL darkModeStyle;

@property(nonatomic, strong) NSDictionary *modeAdapterPlistDic;

@end

@implementation AdapterManager

static AdapterManager *instance = nil;

static dispatch_once_t onceToken;

static bool isFirstAccess = YES;


#pragma mark - Life Cycle
+ (instancetype)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copy {
    return [[AdapterManager alloc] init];
}

- (instancetype)mutableCopy {
    return [[AdapterManager alloc] init];
}

- (instancetype)init {
    if (instance) {
        return instance;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}

#pragma mark - ---- Public ----
/// darkModeManger
+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        instance = [[super allocWithZone:NULL] init];
        instance.shouldFollowSystemMode = YES;
        instance.darkModeStyle = [instance isDarkModeStyle];
        [instance darkModeMonitor];
    });
    return instance;
}

/// destroy manager
+ (void )destroySharedInstance {
    onceToken = 0;
    instance = nil;
}

- (BOOL)isDarkModeStyle {
    if (@available(iOS 13.0, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    } else {
        return NO;
    }
}

/// Config the colors
/// @param bundleName resource bundle name
- (void)configDarkModeColorBundleName:(NSString *)bundleName {
    if (isEmptyString(bundleName)) {
        return;
    }

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];

    NSString *path = [bundlePath stringByAppendingPathComponent:@"AdapterColors.plist"];
    self.modeAdapterPlistDic = [NSDictionary dictionaryWithContentsOfFile:path];
}

/// Gets the color value based on the color name
/// @param colorName color name
- (NSString *)colorHexStringWithColorName:(NSString *)colorName {
    if (isEmptyString(colorName)) {
        return nil;
    }
    
    NSDictionary *colorDic = [self.modeAdapterPlistDic objectForKey:colorName];
    
    if (self.isDarkModeStyle && self.shouldFollowSystemMode) {
        return [colorDic objectForKey:@"dark"];
    } else {
        return [colorDic objectForKey:@"light"];
    }
}

/// Get the corresponding alpha according to the color name
/// @param colorName color name
- (float)colorAlphaWithColorName:(NSString *)colorName {
    if (isEmptyString(colorName)) {
        return 1.0;
    }
    
    NSDictionary *colorDic = [self.modeAdapterPlistDic objectForKey:colorName];
    
    if (self.isDarkModeStyle && self.shouldFollowSystemMode) {
        id darkAlpha = [colorDic objectForKey:@"darkAlpha"];
        if ([darkAlpha isKindOfClass:[NSString class]]
            || [darkAlpha isKindOfClass:[NSNumber class]]) {
            float alpha = [darkAlpha floatValue];
            return MAX(MIN(1.0, alpha), 0.0);
        }
        return 1.0;
    } else {
        id lightAlpha = [colorDic objectForKey:@"lightAlpha"];
        if ([lightAlpha isKindOfClass:[NSString class]]
            || [lightAlpha isKindOfClass:[NSNumber class]]) {
            float alpha = [lightAlpha floatValue];
            return MAX(MIN(1.0, alpha), 0.0);
        }
        return 1.0;
    }
    return 1.0;
}

#pragma mark - ---- Private ----

// It's just monitoring and printing
- (void)darkModeMonitor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 13.0, *)) {
            UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    self.darkModeStyle = YES;
                    NSLog(@"DarkModeKitLog:DarkMode Now !");
                    return [UIColor orangeColor];
                } else {
                    self.darkModeStyle = NO;
                    NSLog(@"DarkModeKitLog: LightMode Now !");
                    return [UIColor grayColor];
                }
            }];
            UIView *unVisibleView = [[UIView alloc] initWithFrame:CGRectZero];
            unVisibleView.backgroundColor = dynamicColor;
            unVisibleView.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:unVisibleView];
        }
    });
}

@end
