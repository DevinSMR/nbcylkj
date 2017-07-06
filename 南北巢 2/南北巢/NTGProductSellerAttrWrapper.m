/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductSellerAttrWrapper.h"
#import "NTGAttribute.h"

/**
 *  Entity - 所有类别商品的分页及属性容器bean
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:21:55 <br/>
 *
 */
@implementation NTGProductSellerAttrWrapper

+ (NSDictionary *)objectClassInArray{
    return @{
             @"attribute":[NTGAttribute class]
            };
}
@end
