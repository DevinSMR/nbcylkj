//
//  NTGClassfiyCell.m
//  南北巢
//
//  Created by nbc on 16/7/15.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGClassfiyCell.h"
@interface NTGClassfiyCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation NTGClassfiyCell
-(void)layoutSubviews{
    self.contentLabel.text = self.content;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
