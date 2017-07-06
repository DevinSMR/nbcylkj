/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"

/**
 * Entity - 个人中心 照片
 *
 * @author wangwei
 * @version 1.0
 */
@interface NTGMemberPhoto : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 照片存储路径 */
@property(nonatomic,copy) NSString *path;

/** 照片标题 */
@property(nonatomic,copy) NSString *title;

/** 评论条数 */
@property(nonatomic,assign) long commentNum;

/** 点赞数 */
@property(nonatomic,assign) long praiseNum;

/** 点击数 */
@property(nonatomic,assign) long hits;

/** 接口地址 */
@property(nonatomic,copy) NSString *staticPath;

/** 图片文件 : 暂不处理（JSJ）*/
//private File file;

/** 照片原名称 */
@property(nonatomic,copy) NSString *name;

@property(nonatomic,strong) NTGMember *member;

/** 创建时间 */
@property(nonatomic,copy) NSString *createDate;

@property (nonatomic,assign) BOOL tag;
@end
