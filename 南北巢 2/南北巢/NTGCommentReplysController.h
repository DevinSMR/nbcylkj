//
//  NTGCommentReplysController.h
//  南北巢
//
//  Created by nbc on 17/4/21.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberComment.h"
@interface NTGCommentReplysController : UIViewController
@property (nonatomic,strong) NTGMemberComment *comment;
@property (nonatomic,assign) long articleID;
@property (nonatomic,assign) NSInteger index;
@end
