/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGParameterGroup.h"
#import "NTGParameter.h"

/**
 * Entity - 参数组
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGParameterGroup

+ (NSDictionary *)objectClassInArray{
    return @{
             @"parameters":[NTGParameter class]
            };
}

@end
