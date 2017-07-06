/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGHomeViewController.h"
#import "NTGSendRequest.h"
#import "NTGGuideController.h"
#import "NTGMemberArticle.h"
#import "NTGJunto.h"
#import "NTGAd.h"
#import "NTGAdPosition.h"
#import "NTGNanBeiPensionController.h"
#import "NTGRujiaPensionController.h"
#import "NTGOldTravelController.h"
#import "NTGProductController.h"
#import "NTGElderlyEstateController.h"
#import "NTGInsuranceController.h"
#import "NTGMBProgressHUD.h"
#import "NTGSearchController.h"
#import "NTGCarouselView.h"
#import "EQPageCycleSize.h"
#import <UIImageView+WebCache.h>
#import "NTGAdPositionController.h"
#import "NTGElderlyFinanceController.h"
#import <UIButton+WebCache.h>
#import "NTGDetection.h"
#import <MJRefresh.h>
#import "NTGAppVersion.h"
//#import "NTGCompress.h"

/**
 * control - 首页控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGHomeViewController ()<UIScrollViewDelegate>
/** 促销活动 */
@property (weak, nonatomic) IBOutlet UIView *promotionsView;
/** 主页面滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet NTGJunto *firstCell;
@property (weak, nonatomic) IBOutlet NTGJunto *twoCell;
@property (weak, nonatomic) IBOutlet NTGJunto *threeCell;
@property (weak, nonatomic) IBOutlet NTGJunto *fourCell;
@property (nonatomic,strong) NSArray *ads;
@property (nonatomic,strong) NSArray *articles;
@property (nonatomic,strong) NTGCarouselView *carouselView;
@property (nonatomic,copy) NSString *adModifyDate;
/** 设置文章 */
- (void)setArticles:(NSArray *)articles;
@end

@implementation NTGHomeViewController

-(void)loadView {
    [super loadView];
    
    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self checkVersion];
    
    self.scroll.bounces = YES;
    self.scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
    }];

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.获得文件的全路径
    NSString *openAdsPath = [doc stringByAppendingPathComponent:@"openAds.plist"];
    NSString *path = [doc stringByAppendingPathComponent:@"memberArticles.plist"];
    NSLog(@"===>%@",path);
    NSArray *memberArticles = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSArray *openAds = [NSKeyedUnarchiver unarchiveObjectWithFile:openAdsPath];
//    if ([NTGDetection netStatus] == NotReachable) {
//        
//    }
    [self setArticles:memberArticles];
    [self addCarouselBtn:openAds];
}

-(void)initData{
    NSDictionary *dict = @{@"id":@"41"};
    [NTGSendRequest getAdWithPosition:dict success:^(NTGAdPosition * adPosition) {
        self.ads = adPosition.openAds;
        self.adModifyDate = adPosition.modifyDate;
        //        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        [self addCarouselBtn:self.ads];
        
        // 2.1.获得Documents的全路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"openAds.plist"];
        //        NSLog(@"====%@",path);
        // 2.3.将对象归档
        [NSKeyedArchiver archiveRootObject:self.ads toFile:path];
    }];
    NSDictionary *dicts = @{@"pageSize":@"4"};
    [NTGSendRequest getJunto:dicts success:^(NSArray *memberArticles) {
        self.articles = memberArticles;
        // 2.1.获得Documents的全路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"memberArticles.plist"];
        // 2.3.将对象归档
        
        [NSKeyedArchiver archiveRootObject:memberArticles toFile:path];
        [self setArticles:memberArticles];
        [self.scroll.mj_header endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.scroll.directionalLockEnabled = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (self.adModifyDate) {
        [self setArticles:self.articles];
        [self addCarouselBtn:self.ads];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/** 搜索 */
- (IBAction)searchBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGSearch" bundle:nil];
    NTGSearchController *searchController = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:searchController animated:YES];
}

/** 分类 */
- (void)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger clickBtnTag =[btn tag];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (clickBtnTag == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NanBeiPension" bundle:nil];
        NTGNanBeiPensionController *nanBeiPensionController = [storyboard instantiateViewControllerWithIdentifier:@"nanBeiPensionController"];
        [self.navigationController pushViewController:nanBeiPensionController animated:YES];
    }else if (clickBtnTag == 1){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RujiaPension" bundle:nil];
        NTGRujiaPensionController *rujiaPensionController = [storyboard instantiateViewControllerWithIdentifier:@"rujiaPensionController"];
        [self.navigationController pushViewController:rujiaPensionController animated:YES];
    }else if (clickBtnTag == 2){
//        dict = @{@"productCategoryId":@"120"};
        [dict setValue:@"120" forKey:@"productCategoryId"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"OldTravel" bundle:nil];
        NTGOldTravelController *oldTravelController = [storyboard instantiateViewControllerWithIdentifier:@"oldTravelController"];
        oldTravelController.reqParam = dict;
        [self.navigationController pushViewController:oldTravelController animated:YES];
    }else if (clickBtnTag == 3){
//        dict = @{@"productCategoryId":@"88",@"_categoryNav_":@"养生保健"};
        [dict setValue:@"88" forKey:@"productCategoryId"];
        [dict setValue:@"养生保健" forKey:@"_categoryNav_"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProduct" bundle:nil];
        NTGProductController *productController = [storyboard instantiateViewControllerWithIdentifier:@"productController"];
        productController.reqParam = dict;
        [self.navigationController pushViewController:productController animated:YES];
    }else if (clickBtnTag == 4){
//        dict = @{@"id":@"20",@"productCategoryId":@"116",@"_categoryNav_":@"老年用品"};
        [dict setValue:@"116" forKey:@"productCategoryId"];
        [dict setValue:@"老年用品" forKey:@"_categoryNav_"];
        [dict setValue:@"20" forKey:@"id"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProduct" bundle:nil];
        NTGProductController *productController = [storyboard instantiateViewControllerWithIdentifier:@"productController"];
        productController.reqParam = dict;
        [self.navigationController pushViewController:productController animated:YES];
    }else if (clickBtnTag == 5){
        [dict setValue:@"养老保险" forKey:@"_categoryNav_"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Insurance" bundle:nil];
        NTGInsuranceController *insuranceController = [storyboard instantiateViewControllerWithIdentifier:@"insuranceController"];
        insuranceController.reqParam = dict;
        [self.navigationController pushViewController:insuranceController animated:YES];
    }else if (clickBtnTag == 6){
        [dict setValue:@"养老地产" forKey:@"_categoryNav_"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ElderlyEstate" bundle:nil];
        NTGElderlyEstateController *elderlyEstateController = [storyboard instantiateViewControllerWithIdentifier:@"elderlyEstateController"];
        elderlyEstateController.reqParam = dict;
        [self.navigationController pushViewController:elderlyEstateController animated:YES];
    }else if (clickBtnTag == 7){
        [dict setValue:@"养老金融" forKey:@"_categoryNav_"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ElderlyFinance" bundle:nil];
        NTGElderlyFinanceController *elderlyFinanceController = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:elderlyFinanceController animated:YES];
    }
}

/** 巢友指南 */
- (IBAction)clickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger clickBtnTag =[btn tag];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGGuideList" bundle:nil];
    NTGGuideController *guideController = [storyboard instantiateInitialViewController];
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    if (clickBtnTag == 100) {
        [dicts setObject:@"subjectElderly" forKey:@"type"];
        [dicts setObject:@"主题养老" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 200){
        [dicts setValue:@"southNorthCulture" forKey:@"type"];
        [dicts setValue:@"南北文化" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 300){
        [dicts setValue:@"seasonElderly" forKey:@"type"];
        [dicts setValue:@"当季养老" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 400){
        [dicts setValue:@"homeInnCulture" forKey:@"type"];
        [dicts setValue:@"如家文化" forKey:@"_categoryNav_"];
    }
    guideController.reqParam = dicts;
    [self.navigationController pushViewController:guideController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareUI {
    NSArray *labelTextA = @[@"南北养老",@"如家养老",@"老年旅游",@"养生保健",@"老年用品",@"养老保险",@"养老地产",@"养老金融"];
    for (int j = 0; j<8; j++) {
        UIButton *btn = [[UIButton alloc]init];
        UILabel *label = [[UILabel alloc]init];
        if (UI_SCREEN_WIDTH == 320) {
            CGFloat magin = (UI_SCREEN_WIDTH - 30 - 65*4)/3;
            if (j<=3) {
                btn.frame = CGRectMake(15+(magin+65)*j, 273, 65, 65);
                label.frame = CGRectMake(15+(magin+65)*j, 351, 65, 17);
            }
            if (j>3 && j<8) {
                btn.frame = CGRectMake(15+(magin+65)*(j-4), 393, 65, 65);
                label.frame = CGRectMake(15+(magin+65)*(j-4), 471, 65, 17);
            }
//            self.cuxiaoH.constant = 519;
        }
        if (UI_SCREEN_WIDTH == 375) {
            CGFloat magin = (UI_SCREEN_WIDTH - 40 - 75*4)/3;
            if (j<=3) {
                btn.frame = CGRectMake(20+(magin+75)*j, 273, 75, 75);
                label.frame = CGRectMake(20+(magin+75)*j, 361, 75, 17);
            }
            if (j>3 && j<8) {
                btn.frame = CGRectMake(20+(magin+75)*(j-4), 393, 75, 75);
                label.frame = CGRectMake(20+(magin+75)*(j-4), 481, 75, 17);
            }

//            self.cuxiaoH.constant = 539;
        }
        if (UI_SCREEN_WIDTH == 414) {
            CGFloat magin = (UI_SCREEN_WIDTH - 40 - 85*4)/3;
            if (j<=3) {
                btn.frame = CGRectMake(20+(magin+85)*j, 273, 85, 85);
                label.frame = CGRectMake(20+(magin+85)*j, 361, 85, 17);
            }
            if (j>3 && j<8) {
                btn.frame = CGRectMake(20+(magin+85)*(j-4), 393, 85, 85);
                label.frame = CGRectMake(20+(magin+85)*(j-4), 481, 85, 17);
            }
//            self.cuxiaoH.constant = 559;
        }
        [label setText:labelTextA[j]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fenlei%d",j]] forState:UIControlStateNormal];
        btn.tag = j;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:btn];
        [self.scroll addSubview:label];
    }
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, 0, UI_CURRENT_SCREEN_WIDTH, 109);
    [self.promotionsView addSubview:self.carouselView];
    NSDictionary *dict = @{@"id":@"41"};
    [NTGSendRequest getAdWithPosition:dict success:^(NTGAdPosition * adPosition) {
        self.ads = adPosition.openAds;
        self.adModifyDate = adPosition.modifyDate;
//        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        [self addCarouselBtn:self.ads];
 
        // 2.1.获得Documents的全路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"openAds.plist"];
//        NSLog(@"====%@",path);
        // 2.3.将对象归档
        [NSKeyedArchiver archiveRootObject:self.ads toFile:path];
    }];
    NSDictionary *dicts = @{@"pageSize":@"4"};
    [NTGSendRequest getJunto:dicts success:^(NSArray *memberArticles) {
        self.articles = memberArticles;
        // 2.1.获得Documents的全路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"memberArticles.plist"];
        // 2.3.将对象归档
        
        [NSKeyedArchiver archiveRootObject:memberArticles toFile:path];
    }];
}

- (void)addCarouselBtn:(NSArray *)openAds {
    CGFloat imageW = UI_SCREEN_WIDTH;
    CGFloat imageH = 89;
    CGFloat imageY = 10;
    for (int i = 0; i < openAds.count; i++) {
        CGFloat imageX;
        imageX = i * imageW *0.5 + 15;
        UIButton *carouselBtn = [[UIButton alloc] initWithFrame:CGRectMake(imageX, imageY, imageW*0.5-15, imageH)];
        carouselBtn.tag = i;
        [carouselBtn addTarget:self action:@selector(adPosition:) forControlEvents:UIControlEventTouchUpInside];
        NTGAd * ad = (NTGAd *)openAds[i];
        NSString * picPath =(NSString *)ad.path;
//        picPath = [NTGCompress compressUrl:picPath width:960 heigth:186];
        NSLog(@"%@",picPath);
        [carouselBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:picPath] forState:UIControlStateNormal];
        CGFloat contentW = (openAds.count*0.5) *imageW;
        self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
        [self.carouselView.scrView addSubview:carouselBtn];
        self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
        self.carouselView.scrView.bounces = NO;
        self.carouselView.scrView.contentOffset = CGPointMake(imageW, 0);
    }
}

- (void)adPosition:(UIButton *)btn {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGAdPosition" bundle:nil];
    NTGAdPositionController *adPositionController = [storyboard instantiateInitialViewController];
    adPositionController.ad = self.ads[btn.tag];
    [self.navigationController pushViewController:adPositionController animated:YES];
}

/** 巢友帮数据 */
- (void)setArticles:(NSArray *)articles {
    
    if(articles.count>0) {
        _firstCell.memberArticle = articles[0];
    }
    if(articles.count>1) {
        _twoCell.memberArticle = articles[1];
    }
    
    if(articles.count>2) {
        _threeCell.memberArticle = articles[2];
    }
    
    if(articles.count>3) {
        _fourCell.memberArticle = articles[3];
    }
}

#pragma mark - 弹出更新的提醒
-(void)checkVersion{
    //当前版本
    NSInteger version = 1;
    
    
    NSDictionary *dict = @{@"appType":@"ios"};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGAppVersion *appVersion) {
        
        
        if (appVersion.versionCode > version) {
            [self showAlertview];
        }
        
        
    };
    [NTGSendRequest getVersion:dict success:result];
    
    
}

-(void)showAlertview{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本是否更新" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即更新",@"下次提醒" ,nil];
    alert.frame = CGRectMake(0, 0, 400, 300);
    [alert show];
    
    
    
}
- (void)willPresentAlertView:(UIAlertView *)alertView {
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //APP的下载地址
        NSString *str = @"https://itunes.apple.com/us/app/%E5%8D%97%E5%8C%97%E5%B7%A2%E5%85%BB%E8%80%81%E7%BD%91/id1216594468?l=zh&ls=1&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
    
}


@end
