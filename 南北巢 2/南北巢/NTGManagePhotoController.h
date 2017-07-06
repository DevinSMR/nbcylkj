//
//  NTGManagePhotoController.h
//  南北巢
//
//  Created by nbc on 17/4/17.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberPhotoAlbum.h"
@interface NTGManagePhotoController : UIViewController
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *descript;
@property (nonatomic,strong) NTGMemberPhotoAlbum *photoAlbum;
@end
