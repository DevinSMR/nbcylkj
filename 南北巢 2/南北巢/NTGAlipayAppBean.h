//
//  NTGAlipayAppBean.h
//  南北巢
//
//  Created by nbc on 16/1/20.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTGAlipayAppBean : NSObject

/** 接口名称 */
@property (nonatomic,copy) NSString *service;

/** 合作者身份ID */
@property (nonatomic,copy) NSString *partner;

/** 参数编码字符集 */
@property (nonatomic,copy) NSString *_input_charset;

/** 服务器异步通知页面路径 */
@property (nonatomic,copy) NSString *notify_url;

/** 商户网站唯一订单号 */
@property (nonatomic,copy) NSString *out_trade_no;

/** 商品名称 */
@property (nonatomic,copy) NSString *subject;

/** 支付类型 */
@property (nonatomic,copy) NSString *payment_type;

/** 卖家支付宝账号 */
@property (nonatomic,copy) NSString *seller_id;

/** 订单总金额 */
@property (nonatomic,copy) NSString *total_fee;

/** 商品描述 */
@property (nonatomic,copy) NSString *body;

/** 签名方式 */
@property (nonatomic,copy) NSString *sign_type;

/** 签名 */
@property (nonatomic,copy) NSString *sign;

/** 参数 */
@property (nonatomic,copy) NSString *parameterMap;


@end
