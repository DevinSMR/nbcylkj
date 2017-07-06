/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 旅客或住客信息
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuest : NSObject

/** 姓名 */
@property(nonatomic,copy) NSString *name;

/** 证件号码 */
@property(nonatomic,copy) NSString *certificatesNumber;

/** 电话 */
@property(nonatomic,copy) NSString *phone;

@end
