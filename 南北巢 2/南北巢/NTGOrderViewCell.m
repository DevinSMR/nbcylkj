/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderViewCell.h"
#import <UIImageView+WebCache.h>
#import "NTGOrderItem.h"

/**
 * view - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderViewCell ()
/** 商家名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblSellerName;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/** 数量 */
@property (weak, nonatomic) IBOutlet UILabel *quantity;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
@implementation NTGOrderViewCell

- (void)setOrderItem:(NTGOrderItem *)orderItem {
    _orderItem = orderItem;
    self.lblSellerName.text = orderItem.product.sellerName;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:orderItem.product.thumbnail]];
    self.price.text = [NSString stringWithFormat:@"￥%.2f",[orderItem.product.price floatValue]];
    
    self.quantity.text = [NSString stringWithFormat:@"x%d",orderItem.quantity];
    self.lblName.text = orderItem.product.fullName;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
