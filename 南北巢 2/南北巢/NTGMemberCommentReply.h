/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import <UIKit/UIKit.h>
/**
 * Entity - 回复对应的评论
 *
 * @author 许芳源
 * @version 2014-11-24 新建</br>
 *
 */
@interface NTGMemberCommentReply : NSObject

/**回复内容*/
@property(nonatomic,copy) NSString *replyContent;

@property (nonatomic,strong) NSString *createDate;

/** 回复人*/
@property(nonatomic,strong) NTGMember *member;

@property (nonatomic,assign) CGFloat cellHeight;


@end
