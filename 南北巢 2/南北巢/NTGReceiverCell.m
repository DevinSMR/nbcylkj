/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGReceiverCell.h"
#import "NTGChangeReceiverController.h"

/**
 * view - 收货地址
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReceiverCell ()
/** 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *consignee;
/** 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;

/** 空view */
@property (weak, nonatomic) IBOutlet UIView *onView;
/** 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *lblConsignee;
/** 详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@end
@implementation NTGReceiverCell

-(void)setReceiver:(NTGReceiverContent *)receiver {
    _receiver = receiver;
    [self setReceiverDefalut: _receiver.isDefault];
    self.consignee.text = receiver.consignee;
    self.phone.text = receiver.phone;
    self.address.text = [receiver.areaName stringByAppendingString:receiver.address];
}

- (void)awakeFromNib {
   
}

- (void)setReceiverDefalut:(BOOL)selected {
    self.chooseBtn.selected = selected;
//    if (selected) {
//        self.backgroundColor = [UIColor colorWithRed:252.0/255 green:161.0/255 blue:132.0/255 alpha:1];
//        self.onView.backgroundColor = self.backgroundColor;
//        
//        self.consignee.textColor = [UIColor whiteColor];
//        self.phone.textColor = [UIColor whiteColor];
//        self.address.textColor = [UIColor whiteColor];
//        self.lblAddress.textColor = [UIColor whiteColor];
//        self.lblConsignee.textColor = [UIColor whiteColor];
//    }else {
//        self.backgroundColor = [UIColor whiteColor];
//        self.onView.backgroundColor = self.backgroundColor;
//        self.consignee.textColor = [UIColor blackColor];
//        self.phone.textColor = [UIColor blackColor];
//        self.address.textColor = [UIColor grayColor];
//        self.lblAddress.textColor = [UIColor grayColor];
//        self.lblConsignee.textColor = [UIColor blackColor];
//    }
}


@end
