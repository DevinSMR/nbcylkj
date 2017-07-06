/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGClassCell.h"
/**
 * view - 分类导航左侧单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGclassCell ()

@end
@implementation NTGclassCell

///** 加载cell */
//+ (instancetype)cellWithTableView:(UITableView *)tableView{
//    static NSString *ID = @"classCell";
//    NTGclassCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    return cell;
//}

/** 模型setter方法 */
- (void)setCategoryNav:(NTGCategoryNavigation *)categoryNav {
    _categoryNav = categoryNav;
    self.lblName.text = _categoryNav.name;
//    self.textLabel.text = _categoryNav.name;
//    self.textLabel.font = [UIFont systemFontOfSize:15];
//    self.textLabel.textColor = [UIColor darkGrayColor];
}

/** 选中代理方法 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
