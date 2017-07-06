/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"
/**
 * view - 右侧列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@protocol NTGRightTavleViewDelegate <NSObject>

/** 请求代理方法 */
-(void)clickRightindexPathRow:(NTGCategoryNavigation *)categoryNav index:(int)index;

@end
@interface NTGRightTableVIew : UITableView

/** 模型数组 */
@property (nonatomic ,strong) NSArray *categoryNavs;

/** 行索引 */
@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<NTGRightTavleViewDelegate>delegateRight;
@end
