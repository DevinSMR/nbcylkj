/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMemberCommentReply.h"

/**
 * Entity - 回复对应的评论
 *
 * @author 许芳源
 * @version 2014-11-24 新建</br>
 *
 */
@implementation NTGMemberCommentReply
-(CGFloat)cellHeight{
    CGSize size  = [self.replyContent boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 66, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;


    return size.height + 62 + 32;




}
@end
