/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInsuranceCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 保险单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */
@interface NTGInsuranceCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 期限*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimeLimit;
/** 年龄 */
@property (weak, nonatomic) IBOutlet UILabel *lblTag;

@end

@implementation NTGInsuranceCell

/** 模型setter方法 */
- (void)setInsuranceContent:(NTGInsuranceContent *)insuranceContent {
    _insuranceContent = insuranceContent;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:insuranceContent.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblName.text = insuranceContent.product.name;
    self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[insuranceContent.product.price floatValue]];
    self.lblTimeLimit.text = insuranceContent.timeLimit;
    self.lblTag.text = insuranceContent.age;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"insuranceCell";
    NTGInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGInsuranceCell" owner:nil options:nil]lastObject];
    }
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
