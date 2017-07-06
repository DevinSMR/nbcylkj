//
//  NTGSpecificationBean.m
//  南北巢
//
//  Created by nbc on 16/5/13.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGSpecificationBean.h"

@implementation NTGSpecificationBean

+ (NSDictionary *)objectClassInArray{
    return @{
             @"specificationValues":[NTGSpecificationValueBean class]
             };
}

@end
