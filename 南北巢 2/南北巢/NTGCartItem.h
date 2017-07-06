/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
/**
 * Entity - 购物车项
 * @author dawei
 *
 * @version 2015-3-31 下午1:28:28 <br/>
 *
 */
@interface NTGCartItem : NSObject

@property(nonatomic,assign) BOOL flag;

@property(nonatomic,copy) NSString *id;

/** 数量 */
@property(nonatomic,assign) int quantity;

/** 商品 */
@property(nonatomic,strong) NTGProductContent *product;

/** 单价 */
@property(nonatomic,strong) NSDecimalNumber *unitPrice;

/** 小计 */
@property(nonatomic,strong) NSDecimalNumber *subtotal;

@end
