//
//  NTGPublishCommentController.h
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NTGPublishCommentController : UIViewController
//文章的ID
@property (nonatomic,assign) long memberArticleId;
@property (nonatomic,copy)void(^refuresh)();
@end
