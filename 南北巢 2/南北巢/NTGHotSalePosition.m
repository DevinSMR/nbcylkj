/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGHotSalePosition.h"
#import "NTGProductContent.h"
#import "NTGSeller.h"

/**
 * Entity - 热卖商品
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGHotSalePosition

+ (NSDictionary *)objectClassInArray{
    return @{
             @"hotSaleProducts":[NTGProductContent class],
             @"hotSaleSellers" :[NTGSeller class]
            };
}
@end
