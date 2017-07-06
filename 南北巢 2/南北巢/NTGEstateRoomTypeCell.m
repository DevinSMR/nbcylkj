/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGEstateRoomTypeCell.h"
#import "NTGElderlyEstateContent.h"
#import <UIImageView+WebCache.h>
#import "NTGProductContent.h"

/**
 * view - 养老地产户型
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGEstateRoomTypeCell ()
/** 户型图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconRoomImage;
/** 户型名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblRoomName;

@end

@implementation NTGEstateRoomTypeCell

-(void)setProject:(NTGProductContent *)project {
    _project = project;
    [self.iconRoomImage sd_setImageWithURL:[NSURL URLWithString:project.image]];
    self.lblRoomName.text = project.name;
}

/** 加载Xib */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"roomTypeCell";
    NTGEstateRoomTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
