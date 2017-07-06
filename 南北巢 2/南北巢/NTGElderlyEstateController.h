/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"

/**
 * control - 养老地产
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGElderlyEstateController : UIViewController

/** 详情模型 */
@property(nonatomic, strong) NTGCategoryNavigation *categoryNav;

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;
@end
