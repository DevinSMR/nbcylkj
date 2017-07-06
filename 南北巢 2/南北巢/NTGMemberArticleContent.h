/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMemberArticle.h"
#import "NTGPage.h"

/**
 * Entity - 个人中心  文章详情
 *
 * @author wangwei
 * @version 1.0
 */
@interface NTGMemberArticleContent : NSObject

/** 文章 */
@property(nonatomic,strong) NTGMemberArticle *article;

/** 用户评论 NTGPage中content数组的元素为 ：MemberCommentBean */
@property(nonatomic,strong) NTGPage *memberComments;

@end
