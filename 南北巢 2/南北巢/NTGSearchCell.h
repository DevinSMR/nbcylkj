//
//  NTGSearchCell.h
//  南北巢
//
//  Created by nbc on 17/6/28.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGSearchCell : UICollectionViewCell
@property (nonatomic,strong) NSString *searchStr;
+ (CGSize) getSizeWithText:(NSString*)text;
@end
