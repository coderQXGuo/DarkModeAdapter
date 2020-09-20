//
//  NSString+Adapter.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "NSString+Adapter.h"


@implementation NSString (Adapter)

+ (BOOL)qx_BlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

@end
