/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAreaPikerView.h"

/**
 * view - 区域选择
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAreaPikerView ()


@end
@implementation NTGAreaPikerView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGAreaPikerView *areaPikerView = [[[NSBundle mainBundle]loadNibNamed:@"NTGAreaPikerView" owner:nil options:nil]lastObject];
    return areaPikerView;
}

@end
