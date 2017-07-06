/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCarouselView.h"

/**
 * view -
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGCarouselView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGCarouselView *carouselView = [[[NSBundle mainBundle]loadNibNamed:@"CarouselView" owner:nil options:nil] lastObject];
    return carouselView;
}

/** 模型setter方法 */
- (void)setAd:(NTGAd *)ad {
    _ad = ad;
}

@end
