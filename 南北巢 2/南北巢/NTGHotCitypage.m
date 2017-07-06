/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGHotCitypage.h"
#import "NTGHotCity.h"

/**
 * Entity - 热门城市
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGHotCitypage

+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGHotCity class]
             };
}

@end
