/*
* Copyright 2005-2013 nbcyl.com. All rights reserved.
* Support: http://www.nbcyl.com
* License: http://www.nbcyl.com/license
*/

#import <UIKit/UIKit.h>
#import "NTGMemberArticle.h"

/**
 * control - 巢友帮
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInspirationController : UIViewController

@property(nonatomic,strong) NTGMemberArticle *memberArticle;
@property (nonatomic,copy) void(^priseNum)(NSString *num);
@property (nonatomic,copy) void(^commentsNum)(NSString *num);
@end
