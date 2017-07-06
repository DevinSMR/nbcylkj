//
//  NTGArticleCommentsController.h
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberComments.h"
@interface NTGArticleCommentsController : UIViewController
@property (nonatomic,strong) NTGMemberComments *comments;
//文章的ID
@property (nonatomic,assign) long memberArticleId;
@end
