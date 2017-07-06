/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGArea.h"
#import <MJExtension.h>

/**
 * Entity - 地区
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGArea

MJCodingImplementation

+ (NSDictionary *)objectClassInArray{
    return @{@"children":[NTGArea class]};
}
@end
