/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGProductContent;

/**
 * view - 机构详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAgencyGuestRoom : UITableViewCell

/** 客房 */
@property (nonatomic, getter=isShow) BOOL isShow;

/** 单元格模型 */
@property (nonatomic,strong) NTGProductContent *product;

/** 预定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
@end
