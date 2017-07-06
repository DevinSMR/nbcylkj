//
//  NTGArticleListCell.m
//  南北巢
//
//  Created by Devin on 16/7/1.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGArticleListCell.h"

@interface NTGArticleListCell ()

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//点赞的按钮
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
//点赞的数目
@property (weak, nonatomic) IBOutlet UILabel *praiseLB;

//评论的数量
@property (weak, nonatomic) IBOutlet UILabel *commentNumLb;

//评论
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


//编辑
@property (weak, nonatomic) IBOutlet UIButton *editBtn;


@end
@implementation NTGArticleListCell

-(void)layoutSubviews
{
    self.titleLabel.text = self.article.title;
  NSString *date =  [self dateFromString:self.article.createDate];
    self.dateLabel.text = date;
    self.contentLabel.text = self.article.abstracts;
    self.contentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.praiseLB.text = [NSString stringWithFormat:@"%d",self.article.memberPraiseNum];
    self.commentNumLb.text = [NSString stringWithFormat:@"%ld",self.article.commentNum];
    self.selectBtn.selected = self.article.tag;
    [self.editBtn addTarget:self action:@selector(editArticleAction) forControlEvents:UIControlEventTouchUpInside];

}
-(void)editArticleAction{

    [self.cellDelegate editArticleDelegate:self.article];

}


- (IBAction)commentAction:(id)sender {
    
    [self.cellDelegate showComments:self.article];
}


-(NSString *)dateFromString:(NSString *)string{
    NSString*time = string;
    
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    
    return confromTimespStr;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
