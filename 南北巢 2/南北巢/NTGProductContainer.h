/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
#import "NTGArea.h"

/**
 * Entity - 商品详情
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:08:42 <br/>
 *
 */

@interface NTGProductContainer : NSObject

/** 商品 */
@property(nonatomic,strong) NTGProductContent *product;

/** 地区 */
@property(nonatomic,strong) NTGArea *area;

/** 购物车数量 */
@property(nonatomic,assign) long cartCount;

@end
