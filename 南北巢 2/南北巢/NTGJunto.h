/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGMemberArticle.h"

/**
 * view - 巢友帮单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGJunto : UIView

@property(nonatomic,strong) NTGMemberArticle *memberArticle;

/** 点击按钮 */
@property (weak, nonatomic) IBOutlet UIButton *btn;

/** 添加点击监控 */
- (void)addTarget:(id)target action:(SEL)action;

@end
