/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 老年旅游详情描述
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelIntroView : UIView

/** 加载视图 */
+ (instancetype)viewWithView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *descr;
@property (weak, nonatomic) IBOutlet UILabel *tripdays;

@end
