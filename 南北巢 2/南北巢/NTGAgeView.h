/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
/**
 * view - 年龄段视图
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGAgeView : UIView

/** 加载Cell */
+ (instancetype)viewWithView;

/** 跳过 */
@property (weak, nonatomic) IBOutlet UIButton *jump;

/** 六十岁 */
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
/** 七十岁 */
@property (weak, nonatomic) IBOutlet UIButton *sevenBtn;
/** 八十岁 */
@property (weak, nonatomic) IBOutlet UIButton *eightBtn;

@end
