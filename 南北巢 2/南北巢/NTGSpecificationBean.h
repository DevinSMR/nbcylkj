//
//  NTGSpecificationBean.h
//  南北巢
//
//  Created by nbc on 16/5/13.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTGSpecificationValueBean.h"

@interface NTGSpecificationBean : NSObject

/** 名称 */
//private String name;
@property (nonatomic,copy) NSString *name;

/** 类型 */
//private Type type;
@property (nonatomic,assign) int type;

/** 备注 */
//private String memo;
@property (nonatomic,copy) NSString *memo;

@property (nonatomic,strong) NSArray *specificationValues;

@end
