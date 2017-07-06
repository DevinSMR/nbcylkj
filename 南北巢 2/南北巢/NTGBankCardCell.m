/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGBankCardCell.h"
#import "NTGAttibuteOption.h"
#import <UIImageView+WebCache.h>

/**
 * view - 银行卡
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGBankCardCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 银行名称 */
@property (weak, nonatomic) IBOutlet UILabel *lnlName;

@end
@implementation NTGBankCardCell

-(void)setAttibuteOption:(NTGAttibuteOption *)attibuteOption {
    _attibuteOption = attibuteOption;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:attibuteOption.value]];
    self.lnlName.text = attibuteOption.name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
