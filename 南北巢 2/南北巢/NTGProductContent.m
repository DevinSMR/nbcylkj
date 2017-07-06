/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductContent.h"
#import "NTGTags.h"
#import "NTGProductImage.h"
#import "NTGParameter.h"

/**
 * Entity - 商品详情
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:08:42 <br/>
 *
 */

@implementation NTGProductContent

+ (NSDictionary *)objectClassInArray{
    return @{
             @"tags":[NTGTags class],
             @"productImages" :[NTGProductImage class],
             @"paramValue" :[NTGParameter class],
//             @"specificationValues" :[NTGSpecification class],
             @"specificationValues":[NTGSpecificationValueBean class],
             @"favoriteMemberIds":[NSNumber class]
            };
}

@end
