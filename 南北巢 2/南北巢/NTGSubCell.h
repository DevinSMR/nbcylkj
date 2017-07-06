/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"
/**
 * view - 分类导航右侧单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGSubCell : UITableViewCell

/** 加载Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblClass;

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *subImg;

/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *lblSub;

/** 模型 */
@property (nonatomic ,strong) NTGCategoryNavigation *categoryNav;

@end
