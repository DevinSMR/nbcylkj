/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGSeller.h"

/**
 * tableView - 机构列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol PensionAgencyTableViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickindexPathRow:(NTGSeller *)seller index:(int)index;

@end
@interface NTGPensionAgencyTableView : UITableView

/** 机构列表 */
@property (nonatomic,strong) NSArray *sellers;

/** 行索引 */
//@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<PensionAgencyTableViewDelegate>delegateAgency;


- (void) addSellers:(NSArray *)sellers;

- (void) clearSellers;

@end
