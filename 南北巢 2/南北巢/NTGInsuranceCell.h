/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGInsuranceContent.h"

/**
 * view - 保险单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */
@interface NTGInsuranceCell : UITableViewCell

/** 单元格模型 */
@property (nonatomic,strong) NTGInsuranceContent *insuranceContent;

/** 加载Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
