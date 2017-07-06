/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGFinance;

/**
 * view - 金融列表单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGFinanceCell : UITableViewCell

@property (nonatomic,strong) NTGFinance *finance;

/** 加载Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
