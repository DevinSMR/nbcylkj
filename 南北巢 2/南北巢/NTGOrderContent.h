/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGOrder.h"
#import "NTGPage.h"

/**
 * Entity - 订单详情
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOrderContent : NSObject

/** 订单 */
@property(nonatomic,strong) NTGOrder *order;

/** 订单项 PageBeaN的content每一个元素都是 NTGOrderItem对象*/
@property(nonatomic,strong) NTGPage *orderItems;
//private PageBean<OrderItemContentBean> orderItems;

@end
