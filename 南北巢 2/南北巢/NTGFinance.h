/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"

/**
 * Entity - 金融
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGFinance : NSObject

/** 产品信息 */
@property(nonatomic,strong) NTGProductContent *product;

/** ld */
@property(nonatomic,assign) long id;

/** 名称 */
//@property(nonatomic,copy) NSString *name;

/** 图片 */
//@property(nonatomic,copy) NSString *image;

/** 年化收益 */
@property(nonatomic,copy) NSString *yearIncome;

/** 融资金额 */
@property(nonatomic,copy) NSString *financeScale;

/** 投资期限 */
@property(nonatomic,copy) NSString *investDeadline;

/** 起投金额 */
@property(nonatomic,copy) NSString *startAmount;

/** 详情地址 */
@property(nonatomic,copy) NSString *path;
@end
