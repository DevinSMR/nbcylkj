//
//  NTGMemberComments.m
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGMemberComments.h"
#import "NTGMemberComment.h"
@implementation NTGMemberComments
+ (NSDictionary *)objectClassInArray{
    return @{
             @"content":[NTGMemberComment class]
             
             };
}
@end
