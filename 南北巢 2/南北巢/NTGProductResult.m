//
//  NTGProductResult.m
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGProductResult.h"
#import "NTGProductContent.h"
@implementation NTGProductResult
+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGProductContent class]
             };
}
@end
