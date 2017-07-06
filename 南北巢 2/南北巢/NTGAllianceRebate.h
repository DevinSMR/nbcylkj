/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGAlliancePutIn.h"
#import "NTGSupplier.h"

/**
 * Entity - 联盟
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAllianceRebate : NSObject

/** 联盟投放 */
@property (nonatomic,strong) NTGAlliancePutIn *alliancePutIn;

/** 供应商 */
@property(nonatomic,strong) NTGSupplier *supplier;

/** 投放位置 */
@property(nonatomic,assign) long categoryId;

/** 养老机构返点 */
@property(nonatomic,copy) NSString *rebate;

/** 上级返点 */
@property(nonatomic,copy) NSString *parentRebate;

@end
