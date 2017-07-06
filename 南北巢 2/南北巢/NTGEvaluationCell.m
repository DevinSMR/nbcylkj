/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGEvaluationCell.h"
#import <UIImageView+WebCache.h>
#import "NTGOrderItem.h"

/**
 * view - 评价单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGEvaluationCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;


@end
@implementation NTGEvaluationCell

- (void)setOrderItem:(NTGOrderItem *)orderItem {
    _orderItem = orderItem;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:orderItem.product.thumbnail]];
    _lblName.text = orderItem.fullName;
    if (!orderItem.isReview) {
        [self.reviewBtn setTitle:@"我要评价" forState:UIControlStateNormal];
        [self.reviewBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.reviewBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    }else {
        [self.reviewBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        [self.reviewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.reviewBtn.layer.borderColor = [UIColor blackColor].CGColor;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
