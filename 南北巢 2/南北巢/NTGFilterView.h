/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGAttribute.h"

/**
 * view - 筛选
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol FilterViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickFilterViewIndexPathRow:(NTGAttribute *)attribute index:(NSIndexPath *)index;

@end

@interface NTGFilterView : UIView

/** 加载视图 */
+ (instancetype)viewWithView;

/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

/** 确认按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

/** 筛选条件列表 */
@property (weak, nonatomic) IBOutlet UITableView *termListTable;

/** 删除选项 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic,strong) NSArray *attributes;

/** 代理 */
@property (nonatomic ,weak) id<FilterViewDelegate>delegateFilter;
@end
