//
//  NTGSectionCell.h
//  南北巢
//
//  Created by nbc on 17/6/23.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGSectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (nonatomic,strong) NSString *title;
@end
