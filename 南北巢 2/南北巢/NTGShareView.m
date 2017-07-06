//
//  NTGShareView.m
//  南北巢
//
//  Created by nbc on 17/6/14.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGShareView.h"

@implementation NTGShareView

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGShareView *shareView = [[[NSBundle mainBundle]loadNibNamed:@"NTGShareView" owner:nil options:nil] lastObject];
    return shareView;
}


@end
