//
//  NTGCommentReplyTopCell.m
//  南北巢
//
//  Created by nbc on 17/4/21.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGCommentReplyTopCell.h"
#import <UIImageView+WebCache.h>
@interface NTGCommentReplyTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *memberIcon;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *commentLB;


@end
@implementation NTGCommentReplyTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.memberIcon sd_setImageWithURL:[NSURL URLWithString:self.memberComment.member.picture] placeholderImage:[UIImage imageNamed:@"memberIconReplace"]];
    self.memberName.text = self.memberComment.member.petName;
    self.commentLB.text = self.memberComment.content;
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
