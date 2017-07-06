/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGSeller.h"
#import "NTGGuest.h"
#import "NTGOrderItem.h"
#import "NTGShipping.h"

/**
 * Entity - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOrder : NSObject

/**
 * 发票明细
 */
//public enum InvoiceDetail{
//    
//    /** 养老机构产生费 */
//    elderlyInstitutionFee,
//    /** 老年用品产生费 */
//    elderlyProductFee,
//    /** 旅游产生费*/
//    elderlyTravelFee
//}

/** 订单编号 */
@property(nonatomic,copy) NSString *sn;

/** 应付金额 */
@property(nonatomic,assign) float amountPayable;

/** 订单项 */
@property(nonatomic,strong)  NSArray *orderItems;

/** 商品数量 */
@property(nonatomic,copy) NSString *quantity;

/** 商品价格 */
@property(nonatomic,copy) NSString *price;

/** 运费 */
@property(nonatomic,assign) float freight;

/** 税金 */
@property(nonatomic,copy) NSString *tax;

/** 会员 */
@property(nonatomic,strong) NTGSeller *seller;

/** 房间总价 */
@property(nonatomic,copy) NSString *roomAmount;

/** 订单金额 */
@property(nonatomic,copy) NSString *amount;

/** 旅游总价 */
@property(nonatomic,copy) NSString *tripAmount;

/** 旅游出发日期 */
@property(nonatomic,copy) NSString *tripDate;

/** 旅游儿童个数 */
@property(nonatomic,copy) NSString *childrenCount;

/** 旅游成年人个数 */
@property(nonatomic,copy) NSString *adultCount;

/** 订单状态 */
@property(nonatomic,copy) NSString *orderStatus;

/** 支付状态 */
@property(nonatomic,copy) NSString *paymentStatus;

/** 配送状态 */
@property(nonatomic,copy) NSString *shippingStatus;

/** 下单时间 */
@property(nonatomic,copy) NSString *createDate;

/** 收货人 */
@property(nonatomic,copy) NSString *consignee;

/** 收货人电话 */
@property(nonatomic,copy) NSString *phone;

/** 收货地址 */
@property(nonatomic,copy) NSString *address;

/** 收货地址 */
@property(nonatomic,copy) NSString *areaName;

/** 是否开据发票 */
@property(nonatomic,assign) BOOL isInvoice;

/** 发票抬头 */
@property(nonatomic,copy) NSString *invoiceTitle;

/** 发票明细 ： 枚举类型，参照已经注释掉的代码 */
@property(nonatomic,copy) NSString *invoiceDetail;

/** 发票收货人 */
@property(nonatomic,copy) NSString *invoiceConsignee;

/** 发票地区名称 */
@property(nonatomic,copy) NSString *invoiceAreaName;

/** 发票地址 */
@property(nonatomic,copy) NSString *invoiceAddress;

/** 发票邮编 */
@property(nonatomic,copy) NSString *invoiceZipCode;

/** 旅客或住客信息 */
@property(nonatomic,strong) NSArray *guests;

/** 入住时间 */
@property(nonatomic,copy) NSString *startDate;

/** 离开时间 */
@property(nonatomic,copy) NSString *endDate;

/** 发货单 */
@property(nonatomic,strong) NSArray *shippings;
//private List<ShippingBean> shippings;


@end
