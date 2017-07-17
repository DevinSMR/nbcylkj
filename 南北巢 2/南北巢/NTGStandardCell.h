//
//  NTGStandardCell.h
//  南北巢
//
//  Created by nbc on 17/7/13.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGStandardCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
+ (CGSize) getSizeWithText:(NSString*)text;
@end
