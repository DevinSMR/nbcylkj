/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCartView.h"
#import "NTGLoginController.h"
#import "NTGBavBaseController.h"

/**
 * view - 购物车登陆页
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGCartView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGCartView *cartView = [[[NSBundle mainBundle]loadNibNamed:@"NTGCartView" owner:nil options:nil]lastObject];
    return cartView;
}

/** 立即登陆 */
- (IBAction)loginBtn:(id)sender {
    if ([self.lblCollect.text isEqualToString:@"立即登录"]) {
        if ([_delegateShop respondsToSelector:@selector(popToLogin)]) {
            [_delegateShop popToLogin];
        }
    }
    if ([self.lblCollect.text isEqualToString:@"去收藏"]) {
        if ([_delegateShop respondsToSelector:@selector(popToRootTableBar)]) {
            [_delegateShop popToRootTableBar];
        }
    }
}

/** 去逛逛 */
- (IBAction)gettingAround:(id)sender {
    
    if ([_delegateShop respondsToSelector:@selector(popToRootTableBar)]) {
        [_delegateShop popToRootTableBar];
    }
    
}

@end
