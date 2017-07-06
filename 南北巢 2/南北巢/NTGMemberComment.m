/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMemberComment.h"
#import "NTGMemberCommentReply.h"

/**
 * Entity - 评论
 *
 * @author nbcyl Team
 * @version 3.0
 */
@implementation NTGMemberComment

+ (NSDictionary *)objectClassInArray{
    return @{
             @"memberCommentReplys":[NTGMemberCommentReply class]
             
             };
}

-(CGFloat)cellHeight{
    CGSize size  = [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 66, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    
    return size.height + 62 + 32;
}

@end
