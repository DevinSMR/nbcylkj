//
//  NTGSelectSpecificationValue.m
//  南北巢
//
//  Created by nbc on 16/5/13.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGSelectSpecificationValue.h"


@implementation NTGSelectSpecificationValue

+ (NSDictionary *)objectClassInArray{
    return @{
             @"effectiveSpecifications":[NTGSpecificationBean class]
             };
}

@end
