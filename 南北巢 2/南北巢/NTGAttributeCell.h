/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGAttibuteOption;

/**
 * view - 筛选分类列表单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAttributeCell : UITableViewCell

@property (nonatomic,strong) NTGAttibuteOption *attibuteOption;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
