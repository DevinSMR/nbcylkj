/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
#import "NTGMember.h"

/**
 * Entity - 商品评论
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReviewContent : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 评分 */
@property(nonatomic,assign) int score;

/** 内容 */
@property(nonatomic,copy) NSString *content;

/** 商品 */
@property(nonatomic,strong) NTGProductContent *product;

/** 创建时间 */
@property(nonatomic,copy) NSString *createDate;

/** 会员 */
@property(nonatomic,strong) NTGMember *member;

@end
