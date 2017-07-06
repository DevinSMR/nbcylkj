/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductPage.h"
#import "NTGProductContent.h"

/**
 * Entity - 商品详情
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:08:42 <br/>
 *
 */

@implementation NTGProductPage

+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGProductContent class]
             };
}


@end
