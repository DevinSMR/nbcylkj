/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSeller.h"

/**
 * Entity - 会员管理
 *
 * @author 许芳源
 * @version 2014-10-17 新建</br>
 *
 */
@implementation NTGSeller

+ (NSDictionary *)objectClassInArray{
    return @{
             @"products":[NTGProductContent class]
            };
}

@end
