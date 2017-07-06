//
//  NTGThirdItem.m
//  南北巢
//
//  Created by nbc on 17/6/23.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGThirdItem.h"

@implementation NTGThirdItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)defaultView{
    NTGThirdItem *view = [[[NSBundle mainBundle] loadNibNamed:@"NTGThirdItem" owner:nil options:nil] lastObject];
    return view;
}


@end
