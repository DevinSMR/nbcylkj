/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGMember;

/**
 * control - 找回密码、修改密码
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGLoginPasswordController : UIViewController
@property (nonatomic,strong) NTGMember *member;
@property (nonatomic,copy) NSString *forgetPassword;
@end
