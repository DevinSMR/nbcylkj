/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSelectionGoods.h"
#import "NTGProductContent.h"
#import "NTGSeller.h"
#import "NTGElderlyEstateContent.h"
#import "NTGInsuranceContent.h"
#import "NTGTripContent.h"


/**
 * Entity - 精选商品
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGSelectionGoods

+ (NSDictionary *)objectClassInArray{
    return @{
             @"products":[NTGProductContent class],
             @"sellers":[NTGSeller class],
             @"trips":[NTGTripContent class],
             @"elderlyEstates":[NTGElderlyEstateContent class],
             @"insurances":[NTGInsuranceContent class]
             };
}
@end
