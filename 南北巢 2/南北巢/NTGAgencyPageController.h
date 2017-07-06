/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGSeller;

/**
 * control - 机构详情控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGAgencyPageController : UIViewController

/** 机构模型 */
@property (nonatomic,strong)NTGSeller *seller;

@property (nonatomic,copy) NSString *appPath;
/** 客房 */
@property (nonatomic, getter=isShow) BOOL isShow;
@end
