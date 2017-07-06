/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGPensionAgencyTableView.h"
#import "NTGConstant.h"

/**
 * control - 机构控制器
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGPensionAgencyController : UIViewController <PensionAgencyTableViewDelegate>
/** 机构列表视图 */
@property (weak, nonatomic) IBOutlet NTGPensionAgencyTableView *pensionAgencyTableView;

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;

- (void) pageInitData :(NTGPullRefresh)action;

/** 更新数据 */
- (void) initData:(NTGPullRefresh)action;

/** 获取数据回调 */
- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state;

/** 获取数据失败 */

@end
