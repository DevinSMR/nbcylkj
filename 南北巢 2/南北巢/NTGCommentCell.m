/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCommentCell.h"
#import <UIImageView+WebCache.h>
#import "NTGMemberComment.h"

/**
 * view - 巢友指南详情  评论说说单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *picture;
/** 评论时间 */
@property (weak, nonatomic) IBOutlet UILabel *createDate;


@end

@implementation NTGCommentCell

- (void)setMemberComment:(NTGMemberComment *)memberComment {
    _memberComment = memberComment;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:memberComment.member.picture] placeholderImage:[UIImage imageNamed:@"default_pictures"]];
    NSString*time = memberComment.createDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    self.createDate.text = confromTimespStr;
    self.content.text = memberComment.content;
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"NTGCommentCell";
    NTGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGCommentCell" owner:nil options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
