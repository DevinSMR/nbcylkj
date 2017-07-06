/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * control - 购物车
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGShoppingCartController : UIViewController

/** 记录购物车商品的选中状态 */
-(void)updateCartWithFlag:(BOOL)flag;

/** 更新新购物车中商品的选中状态 */
- (void)replaceCartItems:(NSArray *)newCartItems;

@end
