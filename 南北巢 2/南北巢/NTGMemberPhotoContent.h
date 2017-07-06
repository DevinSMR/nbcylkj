/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMemberPhoto.h"
#import "NTGPage.h"
/**
 * Entity - 个人中心  照片详情
 *
 * @author wangwei
 * @version 1.0
 */
@interface NTGMemberPhotoContent : NSObject

/** 照片 */
@property(nonatomic,strong) NTGMemberPhoto *photo;

/** 用户评论 NTGPage中content数组的元素为 ：MemberCommentBean */
@property(nonatomic,strong) NTGPage *memberComments;
//private PageBean<MemberCommentBean> memberComments;
@end
