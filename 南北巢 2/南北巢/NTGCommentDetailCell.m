/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCommentDetailCell.h"
#import "NTGReviewContent.h"

/**
 * view - 评论详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentDetailCell ()
/** 评论人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthBtn;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *content;
/** 评论时间 */
@property (weak, nonatomic) IBOutlet UILabel *createDate;

@end
@implementation NTGCommentDetailCell

- (void)setReviewContent:(NTGReviewContent *)reviewContent {
    _reviewContent = reviewContent;
    self.username.text = reviewContent.member.username;
    self.content.text = reviewContent.content;
    self.createDate.text = reviewContent.createDate;
    NSString*time = reviewContent.createDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    self.createDate.text = confromTimespStr;
    if (reviewContent.score == 1) {
        self.fifthBtn.selected = YES;
    }else if (reviewContent.score == 2) {
        self.fifthBtn.selected = YES;
        self.fourthBtn.selected = YES;
    }else if (reviewContent.score == 3) {
        self.fifthBtn.selected = YES;
        self.fourthBtn.selected = YES;
        self.thirdBtn.selected = YES;
    }else if (reviewContent.score == 4) {
        self.fifthBtn.selected = YES;
        self.fourthBtn.selected = YES;
        self.thirdBtn.selected = YES;
        self.secondBtn.selected = YES;
    }else if (reviewContent.score == 5) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = YES;
        self.thirdBtn.selected = YES;
        self.fourthBtn.selected = YES;
        self.fifthBtn.selected = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
