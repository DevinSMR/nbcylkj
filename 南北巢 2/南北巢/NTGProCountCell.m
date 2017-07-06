//
//  NTGProCountCell.m
//  南北巢
//
//  Created by nbc on 17/6/12.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGProCountCell.h"

@implementation NTGProCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.countLb.text = @"1";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
