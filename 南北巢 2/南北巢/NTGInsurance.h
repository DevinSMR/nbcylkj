//
//  NTGInsurance.h
//  南北巢
//
//  Created by nbc on 16/4/8.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTGInsurance : NSObject
/** 属性名称*/
@property(nonatomic,copy) NSString *name;

/** 类型*/
@property (nonatomic,assign) int type;

/** 可选项 */
@property(nonatomic,copy) NSString *options;

@end
