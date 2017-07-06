/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrder.h"
#import "NTGOrderItem.h"
#import "NTGShipping.h"
#import "NTGGuest.h"

/**
 * Entity - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGOrder

+ (NSDictionary *)objectClassInArray{
    return @{
             @"orderItems":[NTGOrderItem class],
             @"shippings":[NTGShipping class],
             @"guests":[NTGGuest class]
            };
}
@end
