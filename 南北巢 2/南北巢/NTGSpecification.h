/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGSpecificationTable.h"

/**
 * view - 规格尺寸
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSpecification : UIView

/** 加载视图 */
+ (instancetype)viewWithView;

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *price;

/** 库存 */
@property (weak, nonatomic) IBOutlet UILabel *stock;

/** 商品规格列表 */
@property (weak, nonatomic) IBOutlet NTGSpecificationTable *specificationTable;

/** 购买数量 */
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

/** 加号 */
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

/** 减号 */
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;

/** 加入购物车按钮 */
@property (weak, nonatomic) IBOutlet UIButton *addCartBtn;

/** 立即购买按钮 */
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;


//是立即购买还是加入购物车
@property (nonatomic,assign) BOOL isNowBuy;


//确认
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;


@end
