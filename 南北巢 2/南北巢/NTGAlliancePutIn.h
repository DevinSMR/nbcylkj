/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMemberSite.h"

/**
 * Entity - 联盟投放
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAlliancePutIn : NSObject

/** 会员网站  */
@property(nonatomic,strong) NTGMemberSite *memberSite;

/** 编号 */
@property(nonatomic,copy) NSString *sn;

/** 投放位置 */
@property(nonatomic,copy) NSString *position;

/** 投放图片 */
@property(nonatomic,copy) NSString *image;

/** 推广链接 */
@property(nonatomic,copy) NSString *link;

/** 投放返点 */
@property(nonatomic,strong) NSArray *allianceRebates;

@end
