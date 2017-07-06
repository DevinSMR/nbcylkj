/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGAd.h"
/**
 * view - 头部广告视图
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGCarouselView : UIView
/** 头部广告位页码 */
@property (strong,nonatomic) UIPageControl * pageControl;

/** 头部广告滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 模型 */
@property (strong,nonatomic) NTGAd *ad;

/** 加载视图 */
+ (instancetype)viewWithView;

@end
