/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGProductContent;

/**
 * control - 商品详情
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGProductDetailController : UIViewController

/** 商品 */
@property (nonatomic,strong)NTGProductContent *product;

@property (nonatomic,assign) int count;
@end
