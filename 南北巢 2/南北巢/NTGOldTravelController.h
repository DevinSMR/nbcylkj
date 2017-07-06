/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"

/**
 * control - 老年养老机构
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOldTravelController : UIViewController

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;

/** 详情模型 */
@property(nonatomic, strong) NTGCategoryNavigation *categoryNav;
@end
