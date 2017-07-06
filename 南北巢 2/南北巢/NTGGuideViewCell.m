/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGGuideViewCell.h"
#import "NTGMainController.h"

/**
 * view - 新特性单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation NTGGuideViewCell

- (void)startButtonClick {
    NTGMainController *mainVc = [[NTGMainController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
//    mainVc.navigationController.navigationBar.hidden = YES;
//    [mainVc.navigationController setNavigationBarHidden:YES];
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.hidden = YES;
}

- (UIButton *)startButton {
    if (_startButton == nil) {
        _startButton = [[UIButton alloc] init];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"whats_new_start_btn"] forState:UIControlStateNormal];
        [self.contentView addSubview:_startButton];
        [_startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
    CGFloat w = 161;
    CGFloat h = 40;
    CGFloat x = (self.bounds.size.width - w) / 2;
    CGFloat y = self.bounds.size.height * 0.8;
    self.startButton.frame = CGRectMake(x, y, w, h);
    
}

- (void)setPage:(int)page total:(int)total {
    if (page == total - 1) {
        // 表示最后一页
        self.startButton.hidden = NO;
    } else {
        // 表示不是最后一页
        self.startButton.hidden = YES;
    }
}

- (void)setImgName:(NSString *)imgName
{
    _imgName = imgName;
    self.imgView.image = [UIImage imageNamed:imgName];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
    }
    return self;
}

@end
