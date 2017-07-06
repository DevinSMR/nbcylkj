/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGElderlyEstateContent.h"

/**
 * view - 地产单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGElderlyEstateCell : UITableViewCell

/** 单元格模型 */
@property (nonatomic,strong) NTGElderlyEstateContent *elderlyEstateContent;

/** 加载Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
