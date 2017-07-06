/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCartItem.h"
//
//typedef void(^cartBlock)(id responseObject);
/**
 * view - 购物车商品
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol NTGShopCartOperateDelegate<NSObject>

/** 加减购物车项 */
- (void)plusminis:(UIButton *)btn label:(UILabel *)label cartItem:(NTGCartItem *)cartItem ;

/** 删除购物车项 */
- (void)selectProductId:(long)id flag:(BOOL)flag ;


@end


@interface NTGShoppingCartCell : UITableViewCell

/** 选择商品 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

/** 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

/** 减号 */
@property (weak, nonatomic) IBOutlet UIButton *minus;

/** 加号 */
@property (weak, nonatomic) IBOutlet UIButton *plus;

/** 单元格模型 */
@property (nonatomic,strong) NTGCartItem *cartItem;

/** 代理 */
@property (nonatomic ,weak) id<NTGShopCartOperateDelegate>delegateShop;

@end
