//
//  NTGNestGuideVC.h
//  南北巢
//
//  Created by nbc on 17/6/2.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGScenicRegion.h"
@interface NTGNestGuideVC : UIViewController
/** 模型 */
@property (strong,nonatomic) NTGScenicRegion *scenicRegion;
/** 标题 */
@property (nonatomic,copy) NSString *headLine;
@end
