//
//  NTGAgenyDetailCell.h
//  南北巢
//
//  Created by nbc on 17/7/5.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGAgenyDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UIView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *contentLb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewConstH;
@end
