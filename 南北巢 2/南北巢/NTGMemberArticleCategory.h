/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 用户文章分类
 *
 * @author wangwei
 * @version 1.0
 */
@interface NTGMemberArticleCategory : NSObject <NSCoding>

/** id */
@property(nonatomic,assign) long id;

/** 名称 */
@property(nonatomic,copy)  NSString *name;

@end
