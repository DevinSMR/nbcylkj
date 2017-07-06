//
//  NTGPhotoCollectionViewCell.m
//  南北巢
//
//  Created by nbc on 17/4/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGPhotoCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@interface NTGPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageItem;


@end
@implementation NTGPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
//    _photoSelectBTn.selected = _photo.tag;
    [_imageItem sd_setImageWithURL:[NSURL URLWithString:self.photo.path] placeholderImage:[UIImage imageNamed:@"pictureReplace"]];
    

}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.imageItem.image = nil;

    
}


-(void)setPhoto:(NTGMemberPhoto *)photo{
    if (photo != nil) {
        _photo = photo;
    }

}

@end
