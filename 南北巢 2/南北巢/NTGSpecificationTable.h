/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGSpecificationBean.h"

/**
 * view - 规格尺寸列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
typedef void(^countBlock)(NSString *count);
@interface NTGSpecificationTable : UITableView

@property (nonatomic,strong) NSArray *effectiveSpecifications;
@property (nonatomic,strong) NSString *choseCount;
@property (nonatomic,copy) void(^countBlock)(NSString *count);
@end
