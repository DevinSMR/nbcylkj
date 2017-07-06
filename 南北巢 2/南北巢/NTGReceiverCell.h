/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGReceiverContent.h"

/**
 * view - 收货地址
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReceiverCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

/** 选择默认收货人按钮 */
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (nonatomic,strong) NTGReceiverContent *receiver;
- (void)setReceiverDefalut:(BOOL)selected;
@end
