/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 旅客信息
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelerCell : UITableViewCell
/** 旅客姓名 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/** 旅客身份证号 */
@property (weak, nonatomic) IBOutlet UITextField *certificatesNumber;
/** 旅客电话 */
@property (weak, nonatomic) IBOutlet UITextField *phone;

@end
