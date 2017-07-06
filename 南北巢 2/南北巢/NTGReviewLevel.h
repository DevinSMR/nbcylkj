/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 评论等级
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGReviewLevel : NSObject

/** 全部数量 */
@property(nonatomic,assign) long allCount;

/** 好评数量 */
@property(nonatomic,assign) long positiveCount;

/** 中评数量 */
@property(nonatomic,assign) long moderateCount;

/** 差评数量 */
@property(nonatomic,assign) long negativeCount;
@end
