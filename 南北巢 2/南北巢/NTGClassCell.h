/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"
/**
 * view - 分类导航左侧单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGclassCell : UITableViewCell

///** 加载视图 */
//+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 选中框 */
@property (weak, nonatomic) IBOutlet UIView *boarderView;

/** 分类 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;

/** 模型 */
@property(nonatomic,weak) NTGCategoryNavigation *categoryNav;

@end
