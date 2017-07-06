/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGFinanceCell.h"
#import <UIImageView+WebCache.h>
#import "NTGFinance.h"

/**
 * view - 金融列表单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */
@interface NTGFinanceCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 年化收益 */
@property (weak, nonatomic) IBOutlet UILabel *yearIncome;
/** 投资期限 */
@property (weak, nonatomic) IBOutlet UILabel *investDeadline;
/** 融资金额 */
@property (weak, nonatomic) IBOutlet UILabel *financeScale;

@end

@implementation NTGFinanceCell

- (void)setFinance:(NTGFinance *)finance {
    _finance = finance;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:finance.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblName.text = finance.product.name;
    
    self.yearIncome.text =[@"年化收益：" stringByAppendingString:[[NSString stringWithFormat:@"%.2f",[finance.yearIncome floatValue]] stringByAppendingString:@"%"]];
    float financeLongValue = [finance.financeScale floatValue];
     self.financeScale.text = [@"融资金额：" stringByAppendingString:[NSString stringWithFormat:@"%.2f",financeLongValue]];
    self.investDeadline.text = [@"投资期限：" stringByAppendingString:[finance.investDeadline stringByAppendingString:@"天"]];
}


/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"NTGFinanceCell";
    NTGFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGFinanceCell" owner:nil options:nil]lastObject];
    }

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
