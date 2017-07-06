//
//  NTGNestGuideVC.m
//  南北巢
//
//  Created by nbc on 17/6/2.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGNestGuideVC.h"
#import "JYPagingView.h"
#import "ArtTableViewController.h"
#import "NTGSendRequest.h"
#import "EQPageCycleSize.h"
#import "NTGCarouselView.h"
#import "NTGScenicRegion.h"
#import "NTGScenicRegionContent.h"
#import <UIImageView+WebCache.h>
#import "NTGIntroductionView.h"
#import "NTGCommentView.h"
#import "NTGMBProgressHUD.h"
@interface NTGNestGuideVC ()<HHHorizontalPagingViewDelegate>
@property (nonatomic, strong) HHHorizontalPagingView *pagingView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

@end

@implementation NTGNestGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 改属性设置相当重要
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
    [self.pagingView reload];

}
- (void)initData {
//    self.carouselView = [NTGCarouselView viewWithView];
//    self.carouselView.frame = CGRectMake(0, 65, UI_CURRENT_SCREEN_WIDTH, 240);
//    self.carouselView.scrView.bounces = NO;
//    self.carouselView.scrView.pagingEnabled = YES;
//    self.carouselView.scrView.delegate = self;
//    [self.view addSubview:self.carouselView];
//    
//    [self.introView.webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
//    [self.introductionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"/app/nestguide/content/%ld.jhtml",self.scenicRegion.id];
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGScenicRegionContent *scenicRegionContent) {
        
        
    };
    [NTGSendRequest nestguideContent:nil requestAddr:url success:result];
    
}


#pragma mark -  HHHorizontalPagingViewDelegate
// 下方左右滑UIScrollView设置
- (NSInteger)numberOfSectionsInPagingView:(HHHorizontalPagingView *)pagingView{
    return 4;
}

- (UIScrollView *)pagingView:(HHHorizontalPagingView *)pagingView viewAtIndex:(NSInteger)index{
//    if (index == 0) {
//        NTGIntroductionView *view = [NTGIntroductionView viewWithView];
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//        [webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
//        [scrollView addSubview:webView];
//        return scrollView;
//    }else{
        ArtTableViewController *vc = [[ArtTableViewController alloc] init];
        [self addChildViewController:vc];
        vc.index = index;
        vc.fillHight = self.pagingView.segmentTopSpace + 36;
    vc.scenicRegion = self.scenicRegion;
        return (UIScrollView *)vc.view;
    
}

//headerView 设置
- (CGFloat)headerHeightInPagingView:(HHHorizontalPagingView *)pagingView{
    return 250;
}

- (UIView *)headerViewInPagingView:(HHHorizontalPagingView *)pagingView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor purpleColor];
    scrollView.contentSize = CGSizeMake(1000, 250);
    scrollView.frame = CGRectMake(0, 0, 480, 250);
    //    UIView *headerView = [[UIView alloc] init];
    //    [headerView addSubview:scrollView];
    return scrollView;
}



//segmentButtons
- (CGFloat)segmentHeightInPagingView:(HHHorizontalPagingView *)pagingView{
    return 36.;
}

- (NSArray<UIButton*> *)segmentButtonsInPagingView:(HHHorizontalPagingView *)pagingView{
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 4; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"Home_title_line"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"Home_title_line_select"] forState:UIControlStateSelected];
        NSString *str = nil;
        switch (i) {
            case 0:
                str = @"景点介绍";
                break;
            case 1:
                str = @"门票信息";
                break;
            case 2:
                str = @"交通信息";
                break;
            case 3:
                str = @"评论说说";
                break;
                
            default:
                break;
        }
        [segmentButton setTitle:str forState:UIControlStateNormal];
        segmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        segmentButton.adjustsImageWhenHighlighted = NO;
        [buttonArray addObject:segmentButton];
    }
    return [buttonArray copy];
}

// 点击segment
- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelected:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    NSLog(@"%s",__func__);
    if (selectedIndex == 5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelectedSameItem:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    NSLog(@"%s",__func__);
    
}

// 视图切换完成时调用
- (void)pagingView:(HHHorizontalPagingView*)pagingView didSwitchIndex:(NSInteger)aIndex to:(NSInteger)toIndex{
    NSLog(@"%s \n %tu  to  %tu",__func__,aIndex,toIndex);
}

#pragma mark - 懒加载
- (HHHorizontalPagingView *)pagingView{
    if (!_pagingView) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _pagingView = [[HHHorizontalPagingView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) delegate:self];
        _pagingView.segmentTopSpace = 0;
        _pagingView.segmentView.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
        _pagingView.maxCacheCout = 5.;
        _pagingView.isGesturesSimulate = YES;
        [self.view addSubview:_pagingView];
    }
    return _pagingView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
