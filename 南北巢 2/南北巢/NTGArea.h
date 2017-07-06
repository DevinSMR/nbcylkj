/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 地区
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGArea : NSObject <NSCoding>

/** id */
@property(nonatomic,assign) long id;

/** 全称 */
@property(nonatomic,copy) NSString *fullName;

/** 名称 */
@property(nonatomic,copy) NSString *name;

/** 下级地区 */
@property(nonatomic,strong) NSArray *children;

/** 路径 :2015-07-20*/
@property(nonatomic,copy) NSString *treePath;

/** 上级区域ID :2015-07-20 */
@property(nonatomic,assign) long parentId;

@end
