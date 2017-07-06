//
//  NTGPhotoCollectionViewCell.h
//  南北巢
//
//  Created by nbc on 17/4/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberPhoto.h"
@interface NTGPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) NTGMemberPhoto *photo;

@property (weak, nonatomic) IBOutlet UIButton *photoSelectBTn;

@end
