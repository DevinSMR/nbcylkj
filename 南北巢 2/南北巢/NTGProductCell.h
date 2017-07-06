/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGProductContent.h"

/**
 * view - 用品单元格
 *
 * @author nbcyl Team
 * @version 1.0
 */
@interface NTGProductCell : UITableViewCell

/** 选择按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

/** 单元格模型 */
@property (nonatomic,strong) NTGProductContent *productContent;

/** 加载Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView reuseID:(NSString *)reuseID nibNamed:(NSString *)nibNamed;

//+ (NSString *)getReuseID;
@end
