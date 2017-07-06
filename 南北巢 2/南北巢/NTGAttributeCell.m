/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAttributeCell.h"
#import "NTGAttibuteOption.h"

/**
 * view - 筛选分类列表单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAttributeCell ()

@end

@implementation NTGAttributeCell

-(void)setAttibuteOption:(NTGAttibuteOption *)attibuteOption {
    _attibuteOption = attibuteOption;
    self.name.text = attibuteOption.name;
    self.chooseBtn.selected = attibuteOption.tag;
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
      NTGAttributeCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGAttributeCell" owner:nil options:nil]lastObject];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
