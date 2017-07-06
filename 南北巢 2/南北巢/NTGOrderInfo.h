/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import "NTGOrder.h"

/**
 * Entity - 商品订单确认订单信息
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOrderInfo : NSObject

/** 会员 */
@property(nonatomic,strong) NTGMember *member;

/** 订单 */
@property(nonatomic,strong) NTGOrder  *order;

/** 配送方式 */
@property(nonatomic,strong) NSArray *shippingMethods;
//private List<ShippingMethodBean> shippingMethods;

/** 支付方式 */
@property(nonatomic,strong) NSArray *paymentMethods;
//private List<PaymentMethodBean> paymentMethods;

/** 支付方式 ????*/
//private List<BigDecimal> shippingMethodAmounts;

/** 购物车令牌 */
@property(nonatomic,copy) NSString *cartToken;

/** 是否启用发票 ：如果为true则展示发票信息，否则不展示*/
@property(nonatomic,assign) BOOL isInvoiceEnabled;

/** 是否启用税率 */
@property(nonatomic,assign) BOOL isTaxPriceEnabled;

/** 发票税金 */
@property(nonatomic,copy) NSString *taxRate;

@end
