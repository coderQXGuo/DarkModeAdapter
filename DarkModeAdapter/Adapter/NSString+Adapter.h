//
//  NSString+Adapter.h
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define isEmptyString(string) [NSString qx_BlankString:string]

@interface NSString (Adapter)

/// check String
+ (BOOL)qx_BlankString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
