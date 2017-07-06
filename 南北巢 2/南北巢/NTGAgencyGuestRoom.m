/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAgencyGuestRoom.h"
#import <UIImageView+WebCache.h>
#import "NTGProductContent.h"
#import "NTGTags.h"

/**
 * view - 机构详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAgencyGuestRoom ()

/** 机构图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/** 机构名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;

/** 客房价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblActualPrice;

/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *lblDescrep;

@end

@implementation NTGAgencyGuestRoom

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
}

/** 模型setter方法 */
- (void)setProduct:(NTGProductContent *)product {
    _product = product;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:product.guestRoom.roomEnvironmentImage]];
    self.lblName.text = product.guestRoom.name;
    self.lblActualPrice.text = [NSString stringWithFormat:@"%.2f",[product.guestRoom.actualPrice floatValue]];
    NSString *roomDesc = product.guestRoom.bedStyle == nil ? @"":product.guestRoom.bedStyle;
    if (product.guestRoom.isComputer) {
        roomDesc = [roomDesc stringByAppendingString:@" 电脑"];
    }
    if (product.guestRoom.isFreeWifi) {
        roomDesc = [roomDesc stringByAppendingString:@" 免费wifi"];
    }
    if (product.guestRoom.isLCTV) {
        roomDesc = [roomDesc stringByAppendingString:@" 电视"];
    }
    if (product.guestRoom.isBloodPressureTest) {
         roomDesc = [roomDesc stringByAppendingString:@" 血压测量"];
    }
    if (product.guestRoom.isBloodSugar) {
         roomDesc = [roomDesc stringByAppendingString:@" 血糖测量"];
    }
    if (product.guestRoom.isIndependentWashingRoom) {
        roomDesc = [roomDesc stringByAppendingString:@" 独立卫生间"];
    }
    if (product.guestRoom.isIndependentKitchen) {
         roomDesc = [roomDesc stringByAppendingString:@" 独立厨房"];
    }
    self.lblDescrep.text = roomDesc;
    if (self.isShow) {
        self.bookBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:96.0/255 blue:12.0/255 alpha:1];
    }else {
        self.bookBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
