/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGParameter;

/**
 * view - 商品参数单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGParameterCell : UITableViewCell

/** 单元格模型 */
@property (nonatomic,strong) NTGParameter *parameter;

@end
