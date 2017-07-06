/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGCategoryNavigation.h"
/**
 * view - 左侧列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@protocol NTGDockTavleViewDelegate <NSObject>

/** 请求代理方法 */
-(void)clickDockindexPathRow:(NTGCategoryNavigation *)categoryNav index:(NSIndexPath *)index;
@end

@interface NTGDockTableVIew : UITableView

/** 模型数组 */
@property (nonatomic ,strong) NSArray *categoryNavs;

/** 行索引 */
@property (nonatomic,assign) NSIndexPath *index;

/** 代理 */
@property (nonatomic ,weak) id<NTGDockTavleViewDelegate>delegateDock;

@end
