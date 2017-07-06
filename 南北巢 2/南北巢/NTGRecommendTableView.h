/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGProductContent.h"

/**
 * view - 商品推荐
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol NTGRecommendTableViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGProductContent *)product index:(int)index;

@end

@interface NTGRecommendTableView : UICollectionView

/** 行索引 */
@property (nonatomic,assign) NSIndexPath *index;

/** 机构列表 */
@property (nonatomic,strong) NSArray *products;

/** 代理 */
@property (nonatomic ,weak) id<NTGRecommendTableViewDelegate>delegateRec;

@end
