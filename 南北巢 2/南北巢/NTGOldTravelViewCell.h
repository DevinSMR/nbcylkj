/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGTripContent.h"

/**
 * view - 老年旅游单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOldTravelViewCell : UITableViewCell

/** 模型 */
@property (strong,nonatomic) NTGTripContent *product;

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
