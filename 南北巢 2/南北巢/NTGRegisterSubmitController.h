/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGMember;

/**
 * control - 注册
 *
 * @author nbcyl Team
 * @version 3.0
 */

//typedef void (^ReturnTextBlock)(NSString *userName,NSString *password);
@interface NTGRegisterSubmitController : UIViewController
@property (nonatomic,strong) NTGMember *member;
//@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
@end
