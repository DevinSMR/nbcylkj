/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 热卖商品
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGHotSalePosition : NSObject

/** 养老用品 */
@property(nonatomic,strong) NSArray *hotSaleProducts;

/** 机构 */
@property(nonatomic,strong) NSArray *hotSaleSellers;

@end
