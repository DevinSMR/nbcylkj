/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSupplierCell.h"
#import "NTGSupplier.h"

/**
 * view - 分销商单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSupplierCell ()
/** 分销商编码 */
@property (weak, nonatomic) IBOutlet UILabel *lblSn;
/** 分销商名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *memberName;
/** 电话号码 */
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end
@implementation NTGSupplierCell

- (void)setSupplier:(NTGSupplier *)supplier {
    _supplier = supplier;
    self.lblSn.text = supplier.sn;
    self.lblName.text = supplier.name;
    self.memberName.text = supplier.member.name;
    self.phone.text = supplier.member.mobile;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
