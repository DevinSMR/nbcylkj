/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGMemberComment;

/**
 * view - 巢友指南详情  评论说说单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentCell : UITableViewCell

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) NTGMemberComment *memberComment;

/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *content;
@end
