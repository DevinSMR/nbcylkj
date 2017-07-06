/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGReceiverContent;

/**
 * control - 收货地址列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
typedef void (^ReturnReceiverBlock)(NTGReceiverContent *receiver);

@interface NTGReceiverListController : UIViewController

@property (nonatomic, copy) ReturnReceiverBlock returnTextBlock;
@property (nonatomic, strong) NSArray *recs;
@property (nonatomic,strong) NTGReceiverContent *receiver;
@end
