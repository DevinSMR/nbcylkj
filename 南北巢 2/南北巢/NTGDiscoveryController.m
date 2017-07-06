/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGDiscoveryController.h"
#import "NTGAgeView.h"
#import "NTGArtidesView.h"
#import "NTGAgencyView.h"
#define kImgCount 3
/**
 * control - 发现控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGDiscoveryController ()

/** 滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;

@property (nonatomic,strong) NTGAgencyView *agencyView;
@end

@implementation NTGDiscoveryController


- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    
//    statusBarView.backgroundColor=[UIColor blackColor];
    
//    [self.view addSubview:statusBarView];
    [self addViews];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/** 准备界面 */
- (void)addViews{
    NTGAgeView *ageView = [NTGAgeView viewWithView];
    self.agencyView = [NTGAgencyView viewWithView];
    
    __weak __typeof(self) weakSelf = self;
    self.agencyView.backToPage = ^(NSInteger index){
        
        weakSelf.scrView.contentOffset = CGPointMake(weakSelf.view.bounds.size.width, 0);
    };
    NTGArtidesView *artidesView = [NTGArtidesView viewWithView];
    artidesView.backToPage = ^(NSInteger index){
        weakSelf.scrView.contentOffset = CGPointMake(weakSelf.view.bounds.size.width * 2, 0);
    
    };
    [ageView.jump addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [ageView.sixBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [ageView.sevenBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [ageView.eightBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    CGFloat imgW = self.view.bounds.size.width;
    CGFloat imgH = self.view.bounds.size.height;
    ageView.frame = CGRectMake(0, 20, imgW, imgH);
    self.agencyView.frame = CGRectMake(imgW, 20, imgW, imgH);
    artidesView.frame = CGRectMake(imgW * 2, 20, imgW, imgH);
    self.scrView.contentSize = CGSizeMake(kImgCount*imgW, 0);
    self.scrView.pagingEnabled = YES;
    self.scrView.showsHorizontalScrollIndicator = NO;
    self.scrView.showsVerticalScrollIndicator = NO;
    self.scrView.bouncesZoom = NO;
    self.scrView.bounces = NO;
    [self.scrView addSubview:ageView];
    [self.scrView addSubview:self.agencyView];
    [self.scrView addSubview:artidesView];
    [self.view addSubview:self.scrView];
}

- (void)change {
    CGFloat imgW = self.view.bounds.size.width;
    CGPoint contentOffset = CGPointMake(imgW, 0);
    [self.scrView setContentOffset:contentOffset animated:YES];
}

@end
