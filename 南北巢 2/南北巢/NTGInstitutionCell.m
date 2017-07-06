/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInstitutionCell.h"
#import <UIImageView+WebCache.h>
#import "NTGTags.h"

/**
 * view - 单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 机构名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblAgency;
/** 机构区域 */
@property (weak, nonatomic) IBOutlet UILabel *lblArea;

/** 是否有标签 */
@property (weak, nonatomic) IBOutlet UILabel *lblRoomOneRe;

/** 客房价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblRoomOnePrice;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceLeftConstraint;

@end
@implementation NTGInstitutionCell

/** 模型setter方法 */
- (void)setSeller:(NTGSeller *)seller {
    _seller = seller;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_seller.institution.institutionFocusImage] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 5;
    self.lblAgency.text = _seller.name;
    self.lblArea.text = _seller.area.name;
    self.lblRoomOnePrice.text = [NSString stringWithFormat:@"¥%@",_seller.institution.startPrice];

    NSArray *prodcutM = _seller.products;
    //先设置标签左边约束为0
    self.leftConstraint.constant = 0;
    for (int p =0 ; p < prodcutM.count; p++) {
        NTGProductContent *product = (NTGProductContent *)prodcutM[p];
        NSArray *tags = product.tags;

        if (p == 0) {
            for (int i = 0; i<tags.count; i++) {
                NTGTags *tg = (NTGTags *)tags[i];
                NSString *tgname = tg.name;
                if ([tgname isEqualToString:@"热"]) {
                    self.leftConstraint.constant = 13;
                    self.lblRoomOneRe.hidden = NO;
                    self.lblRoomOneRe.text = tg.name;
                }else if ([tgname isEqualToString:@"促"]){
                    self.leftConstraint.constant = 13;

                    self.lblRoomOneRe.hidden = NO;

                    self.lblRoomOneRe.text = tg.name;

                }
            }

        }
        
        if (p ==1) {
                for (int i = 0; i<tags.count; i++) {
                    NTGTags *tg = (NTGTags *)tags[i];
                    NSString *tgname = tg.name;
                    if ([tgname isEqualToString:@"热"]) {
                        self.leftConstraint.constant = 13;
                        self.lblRoomOneRe.hidden = NO;
                        self.lblRoomOneRe.text = tg.name;
                    }else if ([tgname isEqualToString:@"促"]){
                        self.leftConstraint.constant = 13;
                        
                        self.lblRoomOneRe.hidden = NO;
                        
                        self.lblRoomOneRe.text = tg.name;
                        
                    }
                }
            
        }

        
        if (p > 1) {
            break;
        }
    }
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"InstitutionCell";
    NTGInstitutionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"InstitutionCell" owner:nil options:nil]lastObject];
    }
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
