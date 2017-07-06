/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGProductContent.h"

/**
 * tableView - 商品列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@protocol ProductTableViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGProductContent *)product index:(int)index;

@end
@interface NTGProductTableView : UITableView

/** 商品 */
@property (nonatomic,strong) NSArray *sellers;

/** 行索引 */
//@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<ProductTableViewDelegate>delegatePro;

- (void) addSellers:(NSArray *)sellers;

- (void) clearSellers;
@end
