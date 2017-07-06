/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGTripContent.h"

/**
 * view - 老年旅游列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol OldTravelTableViewDelegate <NSObject>

/** 请求代理方法 */
-(void)clickDockindexPathRow:(NTGTripContent *)product index:(NSIndexPath *)index;

@end
@interface NTGOldTravelTableView : UITableView

/** 列表模型 */
@property (nonatomic,strong)NSArray *products;

/** 行索引 */
//@property (nonatomic,assign) NSIndexPath *index;

/** 代理*/
@property (nonatomic ,weak) id<OldTravelTableViewDelegate>delegateDock;


- (void)addProducts:(NSArray *)products;

- (void)clearProducts;
@end
