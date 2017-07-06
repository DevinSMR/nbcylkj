/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"

/**
 * Entity - 银行卡
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGBankCard : NSObject

/** 账户名 */
@property(nonatomic,assign) long id;

/** 账户名 */
@property(nonatomic,copy) NSString *accountName;

/** 银行卡号 */
@property(nonatomic,copy) NSString *bankCardNumber;

/** 身份证号 */
@property(nonatomic,copy) NSString *memberIdCard;

/** 预留手机号 */
@property(nonatomic,copy) NSString *bankPhoneNumber;

/** 所属银行 */
@property(nonatomic,copy) NSString *bankName;

/** 所属用户 */
@property(nonatomic,strong) NTGMember *member;

/** 尾号 */
@property(nonatomic,copy) NSString *tailNumber;

/** 是否默认 */
@property(nonatomic,assign) BOOL isDefault;
@end
