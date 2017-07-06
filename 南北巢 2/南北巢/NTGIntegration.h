//
//  NTGIntegration.h
//  南北巢
//
//  Created by nbc on 16/4/19.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTGIntegration : NSObject
/** 名称*/
@property(nonatomic,copy) NSString *name;
/** 数量 */
@property(nonatomic,assign) long num;

/** 分类*/
@property(nonatomic,copy) NSString *category;

/** 子集 */
//private List<IntegrationBean> children;
@property(nonatomic,strong) NSArray *children;

@property (nonatomic, assign, getter = isOpened) BOOL opened;
@end
