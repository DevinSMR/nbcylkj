/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOldTravelViewCell.h"
#import <UIImageView+WebCache.h>
/**
 * view - 老年旅游单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOldTravelViewCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imgTravel;
/** 旅游路线 */
@property (weak, nonatomic) IBOutlet UILabel *lblDiscrep;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 旅游类别 */
@property (weak, nonatomic) IBOutlet UILabel *lblSales;


@end
@implementation NTGOldTravelViewCell

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"oldTravelViewCell";
    NTGOldTravelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OldTravelViewCell" owner:nil options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
/** 模型setter方法 */
-(void)setProduct:(NTGTripContent *)product {
    _product = product;
    self.lblDiscrep.text = _product.name;
//    self.lblDiscrep.font = [UIFont systemFontOfSize:13];
    self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[_product.startPrice floatValue]];
//    self.lblPrice.font = [UIFont systemFontOfSize:13];
    [self.imgTravel sd_setImageWithURL:[NSURL URLWithString:_product.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblSales.text = [NSString stringWithFormat:@"月销%ld笔",_product.product.monthSales];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
