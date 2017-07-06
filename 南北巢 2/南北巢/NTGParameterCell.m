/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGParameterCell.h"
#import "NTGParameter.h"

/**
 * view - 商品参数单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGParameterCell

- (void)setParameter:(NTGParameter *)parameter {
    _parameter = parameter;
    self.textLabel.text = [NSString stringWithFormat:@"%@:",parameter.name];
    self.detailTextLabel.text = parameter.value;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
