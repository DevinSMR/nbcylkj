//
//  NTGInstitutionPage.m
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGInstitutionPage.h"
#import "NTGSeller.h"
@implementation NTGInstitutionPage
+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGSeller class]
             };
}
@end
