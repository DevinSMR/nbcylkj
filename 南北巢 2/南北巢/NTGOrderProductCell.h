/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGOrderItem.h"

/**
 * view - 订单商品
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol NTGOrderProductDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGOrderItem *)orderItem index:(int)index;

@end
@interface NTGOrderProductCell : UITableViewCell

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) NTGOrderItem *orderItem;

/** 行索引 */
@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<NTGOrderProductDelegate>delegateOrderPro;
@end
