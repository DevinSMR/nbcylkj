//
//  CALayer+ButtonBorderColor.h
//  南北巢
//
//  Created by nbc on 16/1/25.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (ButtonBorderColor)

@property(nonatomic, strong) UIColor *borderColorFromUIColor;
- (void)setBorderColorFromUIColor:(UIColor *)color;
@end
