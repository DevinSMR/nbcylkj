//
//  NTGArticleListCell.h
//  南北巢
//
//  Created by Devin on 16/7/1.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberArticle.h"
@protocol editArticleDelegate <NSObject>

-(void)editArticleDelegate:(NTGMemberArticle *)article;

-(void)showComments:(NTGMemberArticle *)article;
@end
@interface NTGArticleListCell : UITableViewCell
@property (nonatomic,strong) NTGMemberArticle *article;
@property (nonatomic,strong) NTGArticleListCell *articleCell;
//选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIButton *bigEditBtn;
@property (nonatomic,assign) id<editArticleDelegate>cellDelegate;
@end
