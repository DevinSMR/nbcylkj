/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGProductContent.h"
#import "NTGSeller.h"

/**
 * control - 机构订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionOrderController : UIViewController

@property (nonatomic,strong) NTGProductContent *product;
@property (nonatomic,strong) NTGSeller *seller;

@end
