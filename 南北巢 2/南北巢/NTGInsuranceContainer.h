//
//  NTGInsuranceContainer.h
//  南北巢
//
//  Created by nbc on 16/4/8.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTGInsurance.h"
#import "NTGInsuranceContent.h"

@interface NTGInsuranceContainer : NSObject

@property(nonatomic,strong) NTGInsurance *insuranceBean;

@property(nonatomic,strong) NTGInsuranceContent *insurance;
@end
