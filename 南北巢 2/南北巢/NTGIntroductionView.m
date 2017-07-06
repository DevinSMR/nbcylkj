/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGIntroductionView.h"

/**
 * view - 巢友指南详情  景点介绍、门票信息、交通信息
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGIntroductionView

/** 加载Cell */
+ (instancetype)viewWithView {
    NTGIntroductionView *introductionView = [[[NSBundle mainBundle]loadNibNamed:@"NTGIntroductionView" owner:nil options:nil]lastObject];
    return introductionView;
}

@end
