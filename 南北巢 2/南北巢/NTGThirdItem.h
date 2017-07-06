//
//  NTGThirdItem.h
//  南北巢
//
//  Created by nbc on 17/6/23.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGThirdItem : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
+(instancetype)defaultView;
@end
