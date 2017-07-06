//
//  CalendarPrices.m
//  南北巢
//
//  Created by nbc on 16/4/12.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "CalendarPrices.h"
#import "CalendarDayModel.h"

@implementation CalendarPrices

+ (NSDictionary *)objectClassInArray{
    return @{
             @"prices":[CalendarDayModel class]
             };
}

@end
