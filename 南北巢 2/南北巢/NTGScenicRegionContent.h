/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGScenicRegion.h"
#import "NTGPage.h"

/**
 * Entity - 景区详情
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGScenicRegionContent : NSObject

/** 景区 */
@property(nonatomic,strong) NTGScenicRegion *scenicRegion;

/** 用户评论 NTGPage中content数组的元素为 ：MemberCommentBean */
@property(nonatomic,strong) NTGPage *memberComments;

@end
