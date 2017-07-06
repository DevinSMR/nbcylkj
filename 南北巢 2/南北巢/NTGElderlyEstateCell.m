/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGElderlyEstateCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 地产单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGElderlyEstateCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *lblAdress;
/** 价格*/
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 热线 */
@property (weak, nonatomic) IBOutlet UILabel *lblHotLine;
/** 热线转 */
@property (weak, nonatomic) IBOutlet UILabel *lblHotLineTurn;

@end
@implementation NTGElderlyEstateCell

/** 模型setter方法 */
- (void)setElderlyEstateContent:(NTGElderlyEstateContent *)elderlyEstateContent {
    _elderlyEstateContent = elderlyEstateContent;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:elderlyEstateContent.projectImage] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 5;
    self.lblName.text = elderlyEstateContent.projectName;
    self.lblAdress.text = elderlyEstateContent.projectAddress;
    self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[elderlyEstateContent.averagePrice floatValue]];
    if (elderlyEstateContent.hotLine) {
        self.lblHotLine.text = elderlyEstateContent.hotLine;
        if (elderlyEstateContent.hotLineTurn) {
            self.lblHotLine.text = [elderlyEstateContent.hotLine stringByAppendingString:@"转"];
            self.lblHotLineTurn.text = elderlyEstateContent.hotLineTurn;
        }
    } 
}

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ElderlyEstateCell";
    NTGElderlyEstateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGElderlyEstateCell" owner:nil options:nil]lastObject];
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
