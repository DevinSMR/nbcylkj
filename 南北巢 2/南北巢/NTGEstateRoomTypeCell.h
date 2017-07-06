/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGProductContent;

/**
 * view - 养老地产户型
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGEstateRoomTypeCell : UITableViewCell

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 单元格模型 */
@property (nonatomic,strong) NTGProductContent *project;


@end
