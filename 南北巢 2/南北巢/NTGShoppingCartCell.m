/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGShoppingCartCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 购物车商品
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGShoppingCartCell ()
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end
@implementation NTGShoppingCartCell

- (void)awakeFromNib {
   
}

/** 模型setter方法 */
- (void)setCartItem:(NTGCartItem *)cartItem {
    _cartItem = cartItem;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:cartItem.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblName.text = cartItem.product.name;
    self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",cartItem.unitPrice.doubleValue];
    self.lblCount.text = [NSString stringWithFormat:@"%d",cartItem.quantity];
    if ([self.lblCount.text intValue] <= 1) {
        [self.minus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
    }else if ([self.lblCount.text intValue] > 1) {
        [self.minus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([self.lblCount.text intValue] == 1) {
            [self.minus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
        }
    }
    [self.minus addTarget:self action:@selector(minusClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.plus addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.cartItem.quantity > 1) {
        [self.minus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.selectBtn.selected = cartItem.flag;
}

/** 加号点击 */
- (void)plusClick:(id)sender {
    if ([_delegateShop respondsToSelector:@selector(plusminis:label:cartItem:)]) {
        [_delegateShop plusminis:self.plus label:self.lblCount cartItem:self.cartItem ];
    }
}

/** 减号点击 */
- (void)minusClick:(id)sender {
    if ([_delegateShop respondsToSelector:@selector(plusminis:label:cartItem:)]) {
        [_delegateShop plusminis:self.minus label:self.lblCount cartItem:self.cartItem];
    }
}

/** 选中按钮 */
- (void)selectClick:(id)sender {
    UIButton *selectBtnSender = (UIButton *)sender;
    selectBtnSender.selected= !selectBtnSender.selected;

    if ([_delegateShop respondsToSelector:@selector(selectProductId:flag:)]) {
        [_delegateShop selectProductId:self.cartItem.product.id flag:selectBtnSender.selected];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
