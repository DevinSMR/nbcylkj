/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCart.h"
#import "NTGCartItem.h"
/**
 * Entity - 购物车
 *
 * @author dawei
 *
 * @version 2015-3-31 下午1:28:20 <br/>
 *
 */
@implementation NTGCart

+ (NSDictionary *)objectClassInArray{
    return @{@"cartItems":[NTGCartItem class]};
}
@end
