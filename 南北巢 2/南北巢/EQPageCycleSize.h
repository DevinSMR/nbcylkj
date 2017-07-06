/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

//判断ios版本
#define IOS_SDK_LESS_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue < (__num)

//屏幕高度
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

//屏幕宽度
#define UI_SCREEN_WIDTH                ([[UIScreen mainScreen] bounds].size.width)

//判断横竖屏
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define UI_CURRENT_SCREEN_WIDTH (IS_LANDSCAPE?\
(IOS_SDK_LESS_THAN(8.0)?UI_SCREEN_HEIGHT:UI_SCREEN_WIDTH)\
:UI_SCREEN_WIDTH)
