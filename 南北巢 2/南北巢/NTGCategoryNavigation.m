/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCategoryNavigation.h"

/**
 * Entity - 分类导航
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGCategoryNavigation

+ (NSDictionary *)objectClassInArray{
    return @{
             @"children":[NTGCategoryNavigation class]
            };
}
@end
