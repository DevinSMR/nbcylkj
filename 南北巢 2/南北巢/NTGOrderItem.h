/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"

/**
 * Entity - 订单项
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOrderItem : NSObject

/** 商品全称 */
@property(nonatomic,copy) NSString *fullName;

/** 商品 */
@property(nonatomic,strong) NTGProductContent *product;

/** 价格 */
@property(nonatomic,assign) float price;

/** 数量 */
@property(nonatomic,assign) int quantity;

/** 是否评价 */
@property(nonatomic,assign) BOOL isReview;

/** 评价id */
@property(nonatomic,assign) long reviewId;

@end
