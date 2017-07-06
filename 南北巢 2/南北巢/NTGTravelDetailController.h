/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGTripContent;

/**
 * control - 旅游详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelDetailController : UIViewController

/** 旅游 */
@property (nonatomic,strong)NTGTripContent *trip;
@property (nonatomic,copy) NSString *appPath;
@end
