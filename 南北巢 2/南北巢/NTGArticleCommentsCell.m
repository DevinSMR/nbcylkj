//
//  NTGArticleCommentsCell.m
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGArticleCommentsCell.h"
#import <UIImageView+WebCache.h>
@interface NTGArticleCommentsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *memberIcon;
@property (weak, nonatomic) IBOutlet UILabel *memberName;

@property (weak, nonatomic) IBOutlet UILabel *memberComment;


@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@property (weak, nonatomic) IBOutlet UILabel *numLB;

@end

@implementation NTGArticleCommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.memberIcon.layer.masksToBounds = YES;
    [self.memberIcon sd_setImageWithURL:[NSURL URLWithString:self.comment.member.picture] placeholderImage:[UIImage imageNamed:@"memberIconReplace"]];
    self.memberName.text = self.comment.member.petName;
    self.memberComment.text = self.comment.content;
    self.timeLB.text = [self dateFromString:self.comment.createDate];
    self.numLB.text = [NSString stringWithFormat:@"%ld",self.comment.memberCommentReplys.count];
    
}

- (IBAction)replyAction:(id)sender  {
    
    [self.cellDelegate replyComment:self.comment index:self.index];
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
