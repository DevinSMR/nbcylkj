/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * control - 是否需要发票
 *
 * @author nbcyl Team
 * @version 3.0
 */

typedef void (^ReturnTextBlock)(NSString *invoice_Title,NSString *invoice_Consignee,NSString *invoice_Address,NSString *invoice_Detail,BOOL isInvoice);
@interface NTGIsInvoiceController : UIViewController
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
@end
