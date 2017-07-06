/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 购物车登陆页
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol NTGCartViewOperateDeleagate <NSObject>

-(void)popToRootTableBar;
-(void)popToLogin;

@end

@interface NTGCartView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblCol;
/** 加载视图 */
+ (instancetype)viewWithView;
/** 去收藏 */
@property (weak, nonatomic) IBOutlet UILabel *lblCollect;

/** 代理 */
@property (nonatomic ,weak) id<NTGCartViewOperateDeleagate>delegateShop;
@property (weak, nonatomic) IBOutlet UILabel *lblDes;

@end
