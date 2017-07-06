//
//  NTGShareView.h
//  南北巢
//
//  Created by nbc on 17/6/14.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTGShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (weak, nonatomic) IBOutlet UIButton *QzoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *penyouBtn;

@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;

@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;

@property (weak, nonatomic) IBOutlet UIButton *copylinkBtn;

/** 加载视图 */
+ (instancetype)viewWithView;

@end
