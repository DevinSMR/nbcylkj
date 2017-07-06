/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGFilterCell.h"
#import "NTGAttribute.h"

/**
 * view - 筛选分类
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGFilterCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@end
@implementation NTGFilterCell

-(void)setAttribute:(NTGAttribute *)attribute {
    _attribute = attribute;
    self.name.text = attribute.name;
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"NTGFilterCell";
    NTGFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGFilterCell" owner:nil options:nil]lastObject];
    }

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
