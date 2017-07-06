/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * control - 发票抬头
 *
 * @author nbcyl Team
 * @version 3.0
 */

typedef void (^ReturnTextBlock)(NSString *showText);
@interface NTGInvoiceController : UIViewController
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
@end
