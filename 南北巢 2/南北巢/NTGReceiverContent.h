/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGArea.h"

/**
 * Entity - 收货地址
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGReceiverContent : NSObject<NSCoding>

/** id */
@property(nonatomic,assign) long id;

/** 收货人 */
@property(nonatomic,copy) NSString *consignee;

/** 地区名称 */
@property(nonatomic,copy) NSString *areaName;

/** 地址 */
@property(nonatomic,copy) NSString *address;

/** 电话 */
@property(nonatomic,copy) NSString *phone;

/** 是否默认 */
@property(nonatomic,assign) BOOL isDefault;

/** 地区 */
@property(nonatomic,strong) NTGArea *area;

/** 邮编 */
@property(nonatomic,copy) NSString *zipCode;

@end
