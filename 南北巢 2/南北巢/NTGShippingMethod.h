/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 配送方式
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGShippingMethod : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 名称 */
@property(nonatomic,copy) NSString *name;

/** 介绍 */
@property(nonatomic,copy) NSString *description;

@end
