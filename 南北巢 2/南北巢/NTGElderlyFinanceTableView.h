/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGFinance.h"

/**
 * view - 金融列表
 *
 * @author nbcyl Team
 * @version 1.0
 */


@protocol ElderlyFinanceTableViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGFinance *)finance index:(int)index;

@end

@interface NTGElderlyFinanceTableView : UITableView

/** 商品 */
@property (nonatomic,strong) NSArray *finances;

/** 行索引 */
//@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<ElderlyFinanceTableViewDelegate>delegateFinance;

//- (void)addSellers:(NSArray *)sellers;

//- (void)clearSellers;



@end
