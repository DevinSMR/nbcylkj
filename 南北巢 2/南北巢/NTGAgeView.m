/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAgeView.h"
//#import "NTGAgencyView.h"

/**
 * view - 年龄段视图
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGAgeView

/** 加载Cell */
+ (instancetype)viewWithView {
    NTGAgeView *ageView = [[[NSBundle mainBundle]loadNibNamed:@"AgeView" owner:nil options:nil] lastObject];
    return ageView;
}

@end
