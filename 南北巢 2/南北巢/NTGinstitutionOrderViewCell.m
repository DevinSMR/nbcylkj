/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGinstitutionOrderViewCell.h"
#import "NTGGuest.h"

/**
 * view - 订单机构
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGinstitutionOrderViewCell ()
/** 入住人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *guestName;
/** 入住人身份证号码 */
@property (weak, nonatomic) IBOutlet UILabel *certificatesNumber;

@end
@implementation NTGinstitutionOrderViewCell

-(void)setGuest:(NTGGuest *)guest {
    _guest = guest;
    self.guestName.text = guest.name;
    self.certificatesNumber.text = guest.certificatesNumber;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
