/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * control - 确认购买
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderCreateController : UIViewController

/** 总价 */
@property(nonatomic,copy)NSString *strTile;
/** 商品id */
@property(nonatomic,strong)NSArray *ids;
/** 令牌 */
@property(nonatomic,copy)NSString *cartToken;
/** 收货人id */
@property(nonatomic,copy)NSString *receiverId;
/** 支付方式id */
@property(nonatomic,copy)NSString *paymentMethodId;
/** 配送方式id */
@property(nonatomic,copy)NSString *shippingMethodId;
@property(nonatomic,strong) NSNumber *orderSn;
@end
