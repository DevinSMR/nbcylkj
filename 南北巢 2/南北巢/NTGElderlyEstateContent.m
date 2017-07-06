/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGElderlyEstateContent.h"
#import "NTGProductContent.h"

@implementation NTGElderlyEstateContent

+ (NSDictionary *)objectClassInArray{
    return @{
             @"roomTypeProduct":[NTGProductContent class]
             };
}

@end
