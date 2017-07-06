/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 巢友指南详情  评论说说
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentView : UIView

/** 加载Cell */
+ (instancetype)viewWithView;

@property (nonatomic,strong) NSArray *memberComments;
@end
