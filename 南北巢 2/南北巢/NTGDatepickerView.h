/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 日期选择器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGDatepickerView : UIView

/** 完成 */
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

/** 选择器视图 */
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

/** 加载视图 */
+ (instancetype)viewWithView;
@end
