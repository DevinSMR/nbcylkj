/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import "NTGMemberArticleCategory.h"

/**
 * Entity - 用户文章
 *
 * @author nbcyl wangwei
 * @version 1.0
 */
@interface NTGMemberArticle : NSObject <NSCoding>

/** id */
@property(nonatomic,assign) long id;

/** 标题 */
@property(nonatomic,copy) NSString *title;

/** 内容 */
@property(nonatomic,copy) NSString *introduction;

/** 摘要 */
@property(nonatomic,copy) NSString *abstracts;

/** 评论条数 */
@property(nonatomic,assign) long commentNum;

/** 点赞数 */
@property(nonatomic,assign) int  memberPraiseNum;

/** 点击数 */
@property(nonatomic,assign) long hits;

/** 创建时间 */
@property(nonatomic,copy) NSString *createDate;

/** 文章分类 */
@property(nonatomic,strong) NTGMemberArticleCategory *memberArticleCategory;

/** 文章存储路径 */
@property(nonatomic,copy) NSString *path;

/** 会员 */
@property(nonatomic,strong) NTGMember *member;

@property(nonatomic,assign) BOOL tag;



@end
