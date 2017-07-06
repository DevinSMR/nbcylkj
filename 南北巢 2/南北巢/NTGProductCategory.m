/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductCategory.h"
#import "NTGParameterGroup.h"
/**
 * Entity - 商品分类
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGProductCategory
+ (NSDictionary *)objectClassInArray{
    return @{
             @"parameterGroups":[NTGParameterGroup class]
            };
}
@end
