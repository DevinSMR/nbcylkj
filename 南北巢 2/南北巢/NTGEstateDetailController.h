/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGElderlyEstateContent;

/**
 * control - 地产详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGEstateDetailController : UIViewController

/** 详情模型 */
@property(nonatomic, strong) NTGElderlyEstateContent *project;

/** 详情模型 */
@property(nonatomic, strong) NSArray *products;

@end
