/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 商品分类
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGProductCategory : NSObject

/** 商品分类id */
@property(nonatomic,assign) long id;

/** 名称 */
@property(nonatomic,copy) NSString *name;

/** 参数组 */
@property(nonatomic,strong) NSArray *parameterGroups;

@end
