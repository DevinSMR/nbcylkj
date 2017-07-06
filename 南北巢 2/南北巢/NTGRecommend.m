/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRecommend.h"
#import <UIImageView+WebCache.h>
#import "UIView+Shadow.h"

/**
 * view - 商品推荐列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRecommend ()
/** 图片 */
@property (weak, nonatomic) UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) UILabel *lblName;
/** 价格 */
@property (weak, nonatomic) UILabel *lblPrice;

@end
@implementation NTGRecommend
/** 模型setter */
- (void)setProduct:(NTGProductContent *)product {
    _product = product;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:product.image]];
    self.lblName.text = product.fullName;
    self.lblName.font = [UIFont systemFontOfSize:14];
    self.lblName.numberOfLines = 2;
    self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",[product.price floatValue]];
    self.lblPrice.font = [UIFont systemFontOfSize:15];
    self.lblPrice.textColor = [UIColor colorWithRed:255.0/255 green:49.0/255 blue:0.0/255 alpha:1];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 100, 100)];
    [iconView makeInsetShadowWithRadius:1.0 Alpha:0.3];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *lblName = [[UILabel alloc] init];
    [self.contentView addSubview:lblName];
    self.lblName = lblName;
    
    UILabel *lblPrice = [[UILabel alloc] init];
    [self.contentView addSubview:lblPrice];
    self.lblPrice = lblPrice;
    
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    lblName.translatesAutoresizingMaskIntoConstraints = NO;
    lblPrice.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(iconView, lblName, lblPrice);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[iconView]|" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lblName]|" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lblPrice]|" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[iconView][lblName][lblPrice]|" options:kNilOptions metrics:nil views:views]];
}

@end
