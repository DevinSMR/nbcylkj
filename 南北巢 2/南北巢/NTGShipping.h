/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 物流信息
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGShipping : NSObject

/** 物流公司 */
@property(nonatomic,copy) NSString *deliveryCorp;

/** 运单号 */
@property(nonatomic,copy) NSString *trackingNo;
@end
