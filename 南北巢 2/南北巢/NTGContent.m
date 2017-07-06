/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGContent.h"
#import "NTGHotCity.h"
@implementation NTGContent

+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGHotCity class]
             };
}

@end
