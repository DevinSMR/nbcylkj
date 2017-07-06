/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import "NTGArea.h"

/**
 * Entity - 分销商
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSupplier : NSObject

/** id */
@property(nonatomic,copy) NSString *id;

/** 分销商名称 */
@property(nonatomic,copy) NSString *name;

/** 分销商编码 */
@property(nonatomic,copy) NSString *sn;

/** 上级分销商名称 */
@property(nonatomic,strong) NTGSupplier *parent;

/** 下级分销商名称 */
@property(nonatomic,strong) NSArray *children;

/** 分销商所在区域 */
@property(nonatomic,strong) NTGArea *area;

/** 会员 */
@property(nonatomic,strong) NTGMember *member;

/** 层级 */
@property(nonatomic,assign) NSInteger grade;

/** 投放返点 */
@property(nonatomic,strong) NSArray *allianceRebates;

@end
