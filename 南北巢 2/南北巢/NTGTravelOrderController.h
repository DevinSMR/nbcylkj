/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGTripContent.h"

/**
 * control - 旅游订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelOrderController : UIViewController
@property (nonatomic,copy) NSString *sstartDate;
@property (nonatomic,copy) NSString *sadultCount;
@property (nonatomic,copy) NSString *schildCount;
@property (nonatomic,copy) NSString *samount;
@property (nonatomic,strong) NTGTripContent *trip;
@end
