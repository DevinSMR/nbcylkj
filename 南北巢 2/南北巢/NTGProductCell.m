/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 用品单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGProductCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 产品名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 原价 */
@property (weak, nonatomic) IBOutlet UILabel *lblStartPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

@end

@implementation NTGProductCell

/** 模型setter方法 */
- (void)setProductContent:(NTGProductContent *)productContent {
    _productContent = productContent;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:productContent.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblName.text = productContent.name;
    self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[productContent.price floatValue]];
//    self.lblStartPrice.text =
//    [NSString stringWithFormat:@"原价￥%.2f",[productContent.marketPrice floatValue]];
//    NSUInteger length = [self.lblStartPrice.text length];
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.lblStartPrice.text];
//    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(2, length-2)];
//    [self.lblStartPrice setAttributedText:attri];
    self.selectBtn.selected = productContent.flag;
    self.lblCount.text = [NSString stringWithFormat:@"%ld条评论",productContent.scoreCount];
}

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView reuseID:(NSString *)reuseID nibNamed:(NSString *)nibNamed {
//    static NSString *ID = @"ProductCell";
    NTGProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:nibNamed owner:nil options:nil]lastObject];
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
