/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"

/**
 * control - 商品控制器
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGProductController : UIViewController

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;

/** 详情模型 */
@property(nonatomic, strong) NTGCategoryNavigation *categoryNav;

//从发现页面进入退出控制器时回调
@property (nonatomic,copy) void(^backToPage)(NSInteger num);
//如果是发现页面进来的则在返回的时候回调
@property (nonatomic,assign) BOOL isDiscovery;
@end
