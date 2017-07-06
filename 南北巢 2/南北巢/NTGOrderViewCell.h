/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGOrderItem;

/**
 * view - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderViewCell : UITableViewCell

@property (nonatomic,strong) NTGOrderItem *orderItem;
@end
