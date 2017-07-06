//
//  CALayer+ButtonBorderColor.m
//  南北巢
//
//  Created by nbc on 16/1/25.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "CALayer+ButtonBorderColor.h"
#import <objc/runtime.h>

@implementation CALayer (ButtonBorderColor)

- (UIColor *)borderColorFromUIColor {
    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
}
-(void)setBorderColorFromUIColor:(UIColor *)color
{
    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
     [self setBorderColorFromUI:self.borderColorFromUIColor];
}
- (void)setBorderColorFromUI:(UIColor *)color
{
    self.borderColor = color.CGColor;
    //    NSLog(@"%@", color);
}
@end
