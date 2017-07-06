/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGAttribute;

/**
 * view - 筛选分类
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGFilterCell : UITableViewCell

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) NTGAttribute *attribute;

@property (weak, nonatomic) IBOutlet UILabel *value;

@end
