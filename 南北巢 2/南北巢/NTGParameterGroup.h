/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 参数组
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGParameterGroup : NSObject

/** 名称 */
@property(nonatomic,copy) NSString *name;

/** 参数 */
@property(nonatomic,strong) NSArray *parameters;

@end
