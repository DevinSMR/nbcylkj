//
//  NTGCommentReplyCell.m
//  南北巢
//
//  Created by nbc on 17/4/21.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGCommentReplyCell.h"
#import <UIImageView+WebCache.h>
@interface NTGCommentReplyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *memberIcon;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *timeLB;


@end
@implementation NTGCommentReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.memberIcon.layer.masksToBounds = YES;
    [self.memberIcon sd_setImageWithURL:[NSURL URLWithString:self.reply.member.picture]];
    self.memberName.text = self.reply.member.petName;
    self.content.text = self.reply.replyContent;
    self.timeLB.text = [self dateFromString:self.reply.createDate];





}
-(void)setReply:(NTGMemberCommentReply *)reply{
    if (reply != nil) {
        _reply = reply;
        CGSize size  = [self.content.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
       // self.reply.cellHeight = size.height + 62;
        self.reply.cellHeight = size.height + 62;
    }



}

-(NSString *)dateFromString:(NSString *)string{
    NSString*time = string;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    
    return confromTimespStr;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
