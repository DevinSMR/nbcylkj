/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 分类导航
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCategoryNavigation : NSObject

/** 导航唯一标识*/
@property(nonatomic,copy) NSString *id;

/** 创建时间 */
@property(nonatomic,copy) NSString *createDate;

/** 最后更新时间 */
@property(nonatomic,copy) NSString *modifyDate;

/** 排序 */
@property(nonatomic,copy) NSString *order;

/** 描述 */
@property(nonatomic,copy) NSString *appDescription;

/** 名称 */
@property(nonatomic,copy) NSString *name;

/** 层级 */
@property(nonatomic,assign) int grade;

/** 上级分类 */
@property(nonatomic,strong) NTGCategoryNavigation *parent;

/** 下级分类 */
@property(nonatomic,strong) NSArray *children;

/** 是否显示 */
@property(nonatomic,assign) BOOL isShow;

/** 展示图片 */
@property(nonatomic,copy) NSString *miniLogo;

/** app 路径 */
@property(nonatomic,copy) NSString *appPath;

@end
