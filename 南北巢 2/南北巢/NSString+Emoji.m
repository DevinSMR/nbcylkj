/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NSString+Emoji.h"

/**
 * tool - 验证表情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NSString (Emoji)

#pragma mark - 判断是否输入表情
+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0,  [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];          // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                isEomji = YES;
            }
             } else {               // non surrogate
                 if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                     isEomji = YES;
                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                     isEomji = YES;
                 } else if (0x2934 <= hs && hs <= 0x2935) {
                     isEomji = YES;
                 } else if (0x3297 <= hs && hs <= 0x3299) {
                     isEomji = YES;
                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs  == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs ==0x2b50|| hs == 0x231a ) {                   isEomji = YES;
                 }
             }
    }];
    return isEomji;
}

@end
