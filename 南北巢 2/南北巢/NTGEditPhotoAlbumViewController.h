//
//  NTGEditPhotoAlbumViewController.h
//  南北巢
//
//  Created by nbc on 17/4/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberPhotoAlbum.h"
@interface NTGEditPhotoAlbumViewController : UIViewController
@property (nonatomic,strong) NTGMemberPhotoAlbum *photoAlbum;
@property (nonatomic,copy) void(^editPhotoAlbum)(NSString *name,NSString *desc);
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *desc;
@end
