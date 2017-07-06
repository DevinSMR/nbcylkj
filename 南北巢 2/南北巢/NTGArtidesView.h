/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
/**
 * view - 养生用品视图
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGArtidesView : UIView

/** 加载Cell */
+ (instancetype)viewWithView;
@property (nonatomic,copy) void(^backToPage)(NSInteger num);
@end
