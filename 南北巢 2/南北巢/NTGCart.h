/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 购物车
 *
 * @author dawei
 *
 * @version 2015-3-31 下午1:28:20 <br/>
 *
 */
@interface NTGCart : NSObject

/** 购物车项 */
@property(nonatomic,strong) NSArray *cartItems;

/** 购物车数量 */
@property(nonatomic,assign) int quantity;

/** 商品价格  java - BigDecimal */
@property(nonatomic,strong) NSDecimalNumber *price;

@end
