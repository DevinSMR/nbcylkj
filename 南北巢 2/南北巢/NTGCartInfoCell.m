/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCartInfoCell.h"
#import "NTGOrderItem.h"
#import <UIImageView+WebCache.h>

/**
 * view - 购物车商品信息
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCartInfoCell ()
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *quantity;

@end
@implementation NTGCartInfoCell

-(void)setOrderItem:(NTGOrderItem *)orderItem {
    _orderItem = orderItem;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:orderItem.product.image]];
    self.lblName.text = orderItem.product.name;
    self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",orderItem.price];
    self.quantity.text = [NSString stringWithFormat:@"%d",orderItem.quantity];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
