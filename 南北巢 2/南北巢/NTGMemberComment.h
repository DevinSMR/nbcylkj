/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import "NTGMemberArticle.h"
#import "NTGMemberPhoto.h"
#import "NTGScenicRegion.h"
#import <UIKit/UIKit.h>
/**
 * Entity - 评论
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGMemberComment : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 内容 */
@property(nonatomic,copy) NSString *content;

/** 创建时间 */
@property(nonatomic,copy) NSString *createDate;

/** 评论人*/
@property(nonatomic,strong) NTGMember *member;

/** 评论对应的文章*/
@property(nonatomic,strong) NTGMemberArticle *memberArticle;

/** 评论对应的照片*/
@property(nonatomic,strong) NTGMemberPhoto *memberPhoto;

/** 评论对应的景区*/
@property(nonatomic,strong) NTGScenicRegion *scenicRegion;

/** 是否匿名*/
@property(nonatomic,assign) BOOL isAnonymous;

/**对应的回复*/
@property(nonatomic,strong) NSArray *memberCommentReplys;

/** 接口地址 */
@property(nonatomic,copy) NSString *path;

@property (nonatomic,assign) CGFloat cellHeight;
@end
