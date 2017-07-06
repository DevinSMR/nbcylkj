/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 巢友指南详情  景点介绍、门票信息、交通信息
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGIntroductionView : UIView

/** 加载Cell */
+ (instancetype)viewWithView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end
