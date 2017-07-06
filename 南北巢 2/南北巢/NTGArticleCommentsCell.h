//
//  NTGArticleCommentsCell.h
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberComment.h"
@protocol replyDelegate <NSObject>

-(void) replyComment:(NTGMemberComment *)comment index:(NSInteger)index;

@end
@interface NTGArticleCommentsCell : UITableViewCell
@property (nonatomic,strong) NTGMemberComment *comment;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (nonatomic,assign) id<replyDelegate>cellDelegate;
@property (nonatomic,assign) NSInteger index;
@end
