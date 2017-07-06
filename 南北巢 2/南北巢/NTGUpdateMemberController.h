/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGMember;

/**
 * control - 更新用户资料
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGUpdateMemberController : UIViewController

/** 模型 */
@property (nonatomic,strong) NTGMember *member;

/** 请求参数 */
@property(nonatomic,strong) NSDictionary * repram;

@end
