//
//  NTGPublisAriticleVC.h
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGMemberArticle.h"
@interface NTGPublisAriticleVC : UIViewController
@property (nonatomic,assign) long articleID;
@property (nonatomic,strong) NTGMemberArticle *article;

@end
