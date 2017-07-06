/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTripContent.h"
#import "NTGTripSummary.h"

/**
 * Entity - 旅游商品
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGTripContent

+ (NSDictionary *)objectClassInArray{
    return @{
             @"tripSummary":[NTGTripSummary class]
            };
}
@end
