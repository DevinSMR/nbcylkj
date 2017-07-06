//
//  NTGMemberArticleDetail.h
//  南北巢
//
//  Created by nbc on 16/4/11.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTGMemberArticle.h"
#import "NTGMemberComments.h"

@interface NTGMemberArticleDetail : NSObject

/** 会员点赞id */
@property(nonatomic,assign) long memberPraiseId;

@property(nonatomic,strong) NTGMemberArticle *article;

@property (nonatomic,strong) NTGMemberComments *memberComments;

/** 点赞数 */
@property(nonatomic,assign) int num;
@end
