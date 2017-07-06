/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGsubCell.h"
#import <UIImageView+WebCache.h>
/**
 * view - 分类导航右侧单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSubCell ()

@end
@implementation NTGSubCell

/** 加载cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SubCell";
    NTGSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGSubCell" owner:nil options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

/** 模型setter方法 */
-(void)setCategoryNav:(NTGCategoryNavigation *)categoryNav {
    _categoryNav = categoryNav;
    self.lblClass.text = _categoryNav.name;
    self.lblClass.font = [UIFont systemFontOfSize:13];
    self.lblSub.text = _categoryNav.appDescription;
    self.lblSub.font = [UIFont systemFontOfSize:12];
    [self.subImg sd_setImageWithURL:[NSURL URLWithString:_categoryNav.miniLogo] placeholderImage:nil];
}

/** 选中方法 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
