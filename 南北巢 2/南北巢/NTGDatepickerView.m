/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGDatepickerView.h"

/**
 * view - 日期选择器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGDatepickerView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGDatepickerView *datepickerView = [[[NSBundle mainBundle]loadNibNamed:@"NTGDatePicker" owner:nil options:nil]lastObject];
    return datepickerView;
}

@end
