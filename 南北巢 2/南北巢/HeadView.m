/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "HeadView.h"
#import "NTGIntegration.h"
//#import "EQPageCycleSize.h"

/**
 * view - 表头
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface HeadView()
{
    UIButton *_bgButton;
    UIImageView *_iconImg;
//    UILabel *_numLabel;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = (HeadView *)[tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:numLabel];
        _numLabel = numLabel;
        
        UIImageView *iconImg = [[UIImageView alloc]init];
//        iconImg.frame = CGRectMake(UI_SCREEN_WIDTH-80, 0, 40, 40);
        [self addSubview:iconImg];
        _iconImg = iconImg;
    }
    return self;
}

- (void)headBtnClick
{
    _integration.opened = !_integration.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}
-(void)setIntegration:(NTGIntegration *)integration {
    _integration = integration;
    
    //    [_bgButton setTitle:integration.name forState:UIControlStateNormal];
    _numLabel.text = [integration.name stringByAppendingString:[NSString stringWithFormat:@"(%ld)",integration.num]];
    _iconImg.image = [UIImage imageNamed:@"att_searchdown"];

}

- (void)didMoveToSuperview
{
    _iconImg.transform = _integration.isOpened ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _iconImg.frame = CGRectMake(self.frame.size.width - 50, 5, 30, 30);
    _numLabel.frame = CGRectMake(20, 0, self.frame.size.width - 80, self.frame.size.height);
}

@end
