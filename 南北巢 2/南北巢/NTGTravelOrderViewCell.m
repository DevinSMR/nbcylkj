/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTravelOrderViewCell.h"
#import "NTGGuest.h"

/**
 * view - 旅游订单
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGTravelOrderViewCell ()
/** 旅客姓名 */
@property (weak, nonatomic) IBOutlet UILabel *guestName;
/** 旅客身份证 */
@property (weak, nonatomic) IBOutlet UILabel *certificatesNum;
/** 旅客手机号 */
@property (weak, nonatomic) IBOutlet UILabel *guestPhone;

@end

@implementation NTGTravelOrderViewCell

-(void)setGuest:(NTGGuest *)guest {
    _guest = guest;
    self.guestName.text = guest.name;
    self.guestPhone.text = guest.phone;
    self.certificatesNum.text = guest.certificatesNumber;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
