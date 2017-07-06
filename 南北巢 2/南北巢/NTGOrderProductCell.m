/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderProductCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 订单商品
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderProductCell ()
/** 缩略图 */
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 数量 */
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
@implementation NTGOrderProductCell

- (void)setOrderItem:(NTGOrderItem *)orderItem {
    _orderItem = orderItem;
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:orderItem.product.thumbnail]];
    self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",[orderItem.product.price floatValue]];
    
    self.lblQuantity.text = [NSString stringWithFormat:@"x%d",orderItem.quantity];
    self.lblName.text = orderItem.product.fullName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       // 這裏返回需要的高度
    return 60;
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"orderProductCell";
    NTGOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGOrderProductCell" owner:nil options:nil]lastObject];
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
