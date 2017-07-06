/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTravelIntroView.h"

/**
 * view - 老年旅游详情描述
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGTravelIntroView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGTravelIntroView *travelIntroView = [[[NSBundle mainBundle]loadNibNamed:@"NTGTravelIntroView" owner:nil options:nil] lastObject];
    return travelIntroView;
}

@end
