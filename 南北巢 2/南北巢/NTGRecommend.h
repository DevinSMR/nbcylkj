/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGProductContent.h"

/**
 * view - 商品推荐列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRecommend : UICollectionViewCell

/** 单元格模型 */
@property (nonatomic,strong) NTGProductContent *product;

@end
