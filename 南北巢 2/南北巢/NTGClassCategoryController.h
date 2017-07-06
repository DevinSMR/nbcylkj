/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */
#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"
//#import "NTGPensionAgencyController.h"
//#import "NTGConstant.h"

/**
 * control - 分类机构列表控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGClassCategoryController : UIViewController

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;

/** 详情模型 */
@property(nonatomic, strong) NTGCategoryNavigation *categoryNav;
@property (nonatomic,copy) void(^backToPage)(NSInteger num);
@property (nonatomic,assign) BOOL isDiscovery;

@end
