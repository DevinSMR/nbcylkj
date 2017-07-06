/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderInfo.h"
#import "NTGShippingMethod.h"
#import "NTGPaymentMethod.h"

/**
 * Entity - 商品订单确认订单信息
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGOrderInfo

+ (NSDictionary *)objectClassInArray{
    return @{
             @"shippingMethods":[NTGShippingMethod class],
             @"paymentMethods":[NTGPaymentMethod class],
             };
}
@end
