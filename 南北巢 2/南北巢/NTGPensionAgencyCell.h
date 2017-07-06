/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

#import "NTGSeller.h"
/**
 * view - 机构列表单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGPensionAgencyCell : UITableViewCell

/** 单元格模型 */
@property (nonatomic,strong) NTGSeller *seller;

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
