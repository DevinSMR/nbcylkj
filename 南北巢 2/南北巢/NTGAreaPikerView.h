/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 区域选择
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAreaPikerView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *areaPiker;

/** 完成 */
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

/** 加载视图 */
+ (instancetype)viewWithView;
@end
