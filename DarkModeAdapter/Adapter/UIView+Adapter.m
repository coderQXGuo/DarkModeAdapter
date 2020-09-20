//
//  UIView+Adapter.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "UIView+Adapter.h"
#import "AdapterManager.h"
#import "UIColor+Adapter.h"
#import "NSString+Adapter.h"
#import <objc/runtime.h>

static void *layerBorderColorHexProperty = &layerBorderColorHexProperty;

static void *layerBackgroundColorHexProperty = &layerBackgroundColorHexProperty;

static void *layerShadowColorHexProperty = &layerShadowColorHexProperty;

@implementation UIView (Adapter)

+ (void)load {
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(traitCollectionDidChange:)),
                                   class_getInstanceMethod(self, @selector(qx_traitCollectionDidChange:)));
}


- (void)qx_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self qx_traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if (![AdapterManager sharedInstance].shouldFollowSystemMode) return;
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        if (state != UIApplicationStateBackground && previousTraitCollection && [self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]){
            if (self.layerBorderColorHex) {
                UIColor *adpterBorderColor = [UIColor colorAdpterWithHexColorName:self.layerBorderColorHex];
                self.layer.borderColor = adpterBorderColor.CGColor;
            }
            if (self.layerBackgroundColorHex) {
                UIColor *layerBackgroundColor = [UIColor colorAdpterWithHexColorName:self.layerBackgroundColorHex];
                self.layer.backgroundColor = layerBackgroundColor.CGColor;
            }
            if (self.layerShadowColorHex) {
                UIColor *layerShadowColor = [UIColor colorAdpterWithHexColorName:self.layerShadowColorHex];
                self.layer.shadowColor = layerShadowColor.CGColor;
            }
            
            [self.layer setNeedsLayout];
        }
    }
}

#pragma mark --------------------------------------------------------------------------------------

- (NSString *)layerBorderColorHex {
    
    return objc_getAssociatedObject(self, layerBorderColorHexProperty);
}

- (void)setLayerBorderColorHex:(NSString *)layerBorderColorHex {
    
    if (isEmptyString(layerBorderColorHex)) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        return;
    }
    UIColor *currentBorderColor = [UIColor colorAdpterWithHexColorName:layerBorderColorHex];
    self.layer.borderColor = currentBorderColor.CGColor;
    objc_setAssociatedObject(self, layerBorderColorHexProperty, layerBorderColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)layerBackgroundColorHex {
    
    return objc_getAssociatedObject(self, layerBackgroundColorHexProperty);
}

- (void)setLayerBackgroundColorHex:(NSString *)layerBackgroundColorHex {
    
    if (isEmptyString(layerBackgroundColorHex)) {
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        return;
    }
    UIColor *layerBackgroundColor = [UIColor colorAdpterWithHexColorName:layerBackgroundColorHex];
    self.layer.backgroundColor = layerBackgroundColor.CGColor;
    objc_setAssociatedObject(self, layerBackgroundColorHexProperty, layerBackgroundColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)layerShadowColorHex {
    return objc_getAssociatedObject(self, layerShadowColorHexProperty);
}

- (void)setLayerShadowColorHex:(NSString *)layerShadowColorHex {
    if (isEmptyString(layerShadowColorHex)) {
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        return;
    }
    
    UIColor *layerShadowColor = [UIColor colorAdpterWithHexColorName:layerShadowColorHex];
    self.layer.shadowColor = layerShadowColor.CGColor;
    objc_setAssociatedObject(self, layerShadowColorHexProperty, layerShadowColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
