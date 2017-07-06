/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGScenicRegion;

/**
 * control - 巢友指南详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGNestGuideController : UIViewController

/** 模型 */
@property (strong,nonatomic) NTGScenicRegion *scenicRegion;
/** 标题 */
@property (nonatomic,copy) NSString *headLine;
@end
