//
//  NTGPhotoListCell.h
//  南北巢
//
//  Created by nbc on 16/7/18.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberPhotoAlbum.h"
@protocol deletePhotoAlbum <NSObject>

-(void)deletePhotoAlum:(long) ID;
-(void)pushToPhotoManager:(NTGMemberPhotoAlbum *)photoAlbum;

@end
@protocol pushToPhotoManagerVC <NSObject>

-(void)pushToPhotoManager:(NTGMemberPhotoAlbum *)photoAlbum;

@end

@interface NTGPhotoListCell : UITableViewCell

//相册
@property (nonatomic,strong) NTGMemberPhotoAlbum *photoAlbum;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) id<deletePhotoAlbum,pushToPhotoManagerVC>cellDelegate;

@end
