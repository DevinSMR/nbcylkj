/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTravelDetailController.h"
#import "EQPageCycleSize.h"
#import "NTGCarouselView.h"
#import "NTGSendRequest.h"
#import "NTGTripContent.h"
#import "NTGTripSummary.h"
#import "NTGProductIntroductionController.h"
#import "NTGTravelBuyController.h"
#import "NTGProductImage.h"
#import <UIImageView+WebCache.h>
#import "NTGTravelIntroView.h"

/**
 * control - 旅游详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelDetailController ()<UIScrollViewDelegate>

/** 头部滚动模块 */
@property (nonatomic,strong) NTGCarouselView *carouselView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 行程概要 */
@property (weak, nonatomic) IBOutlet UILabel *lblTripSummary;

@property (nonatomic,strong) NSMutableArray *strA;
@end

@implementation NTGTravelDetailController

/** 退出控制器 */
- (void)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];  
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/** 更新数据 */
- (void)initData {
    NSString *appPath = @"";
    if (_trip != nil) {
        appPath = _trip.path;
    }else {
        appPath = self.appPath;
    }
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, 0, UI_CURRENT_SCREEN_WIDTH, 270);
    self.carouselView.scrView.bounces = NO;
    self.carouselView.scrView.pagingEnabled = YES;
    self.carouselView.scrView.delegate = self;
    self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.carouselView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.carouselView addSubview:btn];
    [btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    NTGTravelIntroView *view = [NTGTravelIntroView viewWithView];
    view.frame = CGRectMake(0, 240, UI_CURRENT_SCREEN_WIDTH, 30);
    [self.carouselView addSubview:view];
    [NTGSendRequest getTripDetail:nil requestAddr:appPath success:^(NTGTripContent *trip) {
        self.trip = trip;
        self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[self.trip.price floatValue]];
        self.lblName.text = self.trip.name;
        view.name.text = trip.product.productCategory.name;
        view.descr.text = trip.startAreaId.fullName;
        view.tripdays.text = [NSString stringWithFormat:@"行程%@天",trip.tripdays];
        NSArray *productImages = trip.product.productImages;
        
        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        CGFloat imageH = self.carouselView.scrView.frame.size.height;
        CGFloat imageY = 0;
        NSMutableArray *productImagesM = [NSMutableArray array];
        [productImagesM addObject:trip.product.image];
        for (int i=0; i<productImages.count; i++) {
            NTGProductImage *productImage = productImages[i];
            [productImagesM addObject:productImage.medium];
        }
        for (int j=0; j<productImagesM.count; j++) {
            CGFloat imageX = j * imageW;
            UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            [carouselImg sd_setImageWithURL:[NSURL URLWithString:productImagesM[j]] placeholderImage:[UIImage imageNamed:@"icon72"]];
            CGFloat contentW = (productImagesM.count) *imageW;
            self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
            [self.carouselView.scrView addSubview:carouselImg];
        }
        if (self.trip.tripSummary.count>0) {
            self.strA = [NSMutableArray array];
            for (int i=0; i<self.trip.tripSummary.count; i++) {
                NTGTripSummary *tripSummary = self.trip.tripSummary[i];
                NSString *tripStr = tripSummary.summaryName;
                [self.strA addObject:tripStr];
                NSString *str = [self.strA componentsJoinedByString:@">"];
                NSString *string = nil;
                if (i==self.trip.tripSummary.count-1) {
                    string = [NSString stringWithFormat:@"%@",str];
                }else {
                    string = [NSString stringWithFormat:@"%@>",str];
                }
                self.lblTripSummary.text = string;
            }
        }
    }];
}

/** 立即购买 */
- (IBAction)chooseBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGTravelBuy" bundle:nil];
    NTGTravelBuyController *travelBuyController = [storyboard instantiateInitialViewController];
    travelBuyController.trip = self.trip;
    [self.navigationController pushViewController:travelBuyController animated:YES];
}

/** 行程介绍 、费用信息 、预定须知 */
- (IBAction)introductionBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductIntroduction" bundle:nil];
    NTGProductIntroductionController *productIntroduction = [storyboard instantiateInitialViewController];
    if (btn.tag == 100) {
        productIntroduction.intro = self.trip.introduction;
    }
    if (btn.tag == 200) {
        productIntroduction.intro = self.trip.costInfo;
    }
    if (btn.tag == 300) {
        productIntroduction.intro = self.trip.scheduledNotes;
    }
    [self.navigationController pushViewController:productIntroduction animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
