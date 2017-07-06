/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGPensionAgencyCell.h"
#import <UIImageView+WebCache.h>
#import "NTGTags.h"

/**
 * view - 单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGPensionAgencyCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 机构名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblAgency;
/** 起步价 */
@property (weak, nonatomic) IBOutlet UILabel *startPrice;

@end
@implementation NTGPensionAgencyCell

/** 模型setter方法 */
- (void)setSeller:(NTGSeller *)seller {
    _seller = seller;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_seller.institution.institutionFocusImage] placeholderImage:[UIImage imageNamed:@"icon72"]];
    if (_seller.name == nil) {
        self.lblAgency.text = @"";
    }else {
        if (_seller.name.length>12) {
            NSString *s = [_seller.name substringToIndex:12];
            self.lblAgency.text = s;
        }else {
            self.lblAgency.text = _seller.name;
        }
    }
    self.startPrice.text = [NSString stringWithFormat:@"%.2f",[_seller.institution.startPrice floatValue]];

}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"pensionAgencyCell";
    NTGPensionAgencyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PensionAgencyCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
