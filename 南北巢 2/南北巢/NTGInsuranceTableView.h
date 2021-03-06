/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGInsuranceContent.h"

/**
 * view - 保险列表
 *
 * @author nbcyl Team
 * @version 1.0
 */
@protocol InsuranceTableViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGInsuranceContent *)insuranceContent index:(int)index;

@end
@interface NTGInsuranceTableView : UITableView

/** 商品 */
@property (nonatomic,strong) NSArray *sellers;

/** 行索引 */
//@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<InsuranceTableViewDelegate>delegateIns;

- (void) addSellers:(NSArray *)sellers;

- (void) clearSellers;
@end
