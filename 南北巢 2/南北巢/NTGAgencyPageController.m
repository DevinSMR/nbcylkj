/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAgencyPageController.h"
#import "NTGSendRequest.h"
#import "EQPageCycleSize.h"
#import "NTGCarouselView.h"
#import "NTGSeller.h"
#import <UIImageView+WebCache.h>
#import "NTGCommentController.h"
#import "NTGAgencyGuestRoom.h"
#import "NTGInstitutionOrderController.h"
#import "NTGAgencyLocation.h"
#import "NTGAgencyDetailVC.h"
/**
 * control - 机构详情控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAgencyPageController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

/** 头部滚动模块 */
@property (nonatomic,strong) NTGCarouselView *carouselView;
/** 机构名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblAgencyName;
/** 头部滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
/** 客房列表 */
@property (weak, nonatomic) IBOutlet UITableView *agencyDetailTable;
/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *lblAdress;
/** 评论条数 */
@property (weak, nonatomic) IBOutlet UILabel *lblScoreCount;
/** 评分 */
@property (weak, nonatomic) IBOutlet UILabel *lblTotalScore;
/** 图片地址数组 */
@property (nonatomic,strong) NSArray *strA;
/** 详情 */
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
/** 用户评论 */
@property (weak, nonatomic) IBOutlet UIButton *reViewsBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;

@property(nonatomic,assign) int currentPosition;
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** 机构列表 */
@property (nonatomic,strong) NSArray *sellers;
@property (nonatomic,copy) NSString *fullName;
@end

//总运行时间
#define RUNTIME         40
//单条运行时间
#define EACHTIME        10
//每条间隔时间
#define INTERVALTIME    5
@implementation NTGAgencyPageController

/** 退出控制器 */
- (void)backBtn:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.agencyDetailTable.dataSource=self;
    self.agencyDetailTable.delegate=self;
    self.agencyDetailTable.rowHeight = 120;
//    self.agencyDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(msgChange) userInfo:nil repeats:YES];
    self.bgView.clipsToBounds = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
}

- (void)setSellers:(NSArray *)sellers {
    _sellers = sellers;
    [self.agencyDetailTable reloadData];
}

- (void)initData {
    NSString *appPath = @"";
    if (_seller != nil) {
        appPath = _seller.path;
    }else {
        appPath = self.appPath;
    }
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, -20, UI_CURRENT_SCREEN_WIDTH, 270);
    self.carouselView.scrView.bounces = NO;
    self.carouselView.scrView.pagingEnabled = YES;
    self.carouselView.scrView.delegate = self;
    [self.scroll addSubview:self.carouselView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.carouselView addSubview:btn];
    [btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [NTGSendRequest getInstitutionDetail:nil requestAddr:appPath successBack:^(NTGSeller *seller) {
        self.seller = seller;
        self.sellers = seller.products;
        self.isShow = seller.isShow;
        self.viewH.constant = 650 + (self.sellers.count -1)*120;
        self.lblAgencyName.text = seller.name;
        self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[seller.institution.startPrice floatValue]];
        ;
        self.fullName = seller.area.fullName;
        if (seller.address != nil) {
            self.fullName = [self.fullName stringByAppendingString:seller.address];
        }
        self.lblScoreCount.text = [NSString stringWithFormat:@"%ld",seller.scoreCount];
        if (seller.scoreCount) {
            self.lblTotalScore.text = [NSString stringWithFormat:@"%ld",seller.totalScore/seller.scoreCount];
        }else {
            self.lblTotalScore.text = [NSString stringWithFormat:@"%ld",seller.totalScore];
        }
        
        NSMutableArray *strA = [NSMutableArray array];
            NSString *str1 = seller.institution.institutionFacilityImage1;
            NSString *str2 = seller.institution.institutionFacilityImage2;
            NSString *str3 = seller.institution.institutionFacilityImage3;
            NSString *str4 = seller.institution.institutionFacilityImage4;
            NSString *str5 = seller.institution.institutionFacilityImage5;
            NSString *str6 = seller.institution.institutionFocusImage;
        if (str1 != nil) {
            [strA addObject:str1];
        }
        if (str2 != nil) {
            [strA addObject:str2];
        }
        if (str3 != nil) {
            [strA addObject:str3];
        }
        if (str4 != nil) {
            [strA addObject:str4];
        }
        if (str5 != nil) {
            [strA addObject:str5];
        }
        if (str6 != nil) {
            [strA addObject:str6];
        }
        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        CGFloat imageH = self.carouselView.scrView.frame.size.height;
        CGFloat imageY = 0;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 240, UI_CURRENT_SCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        [self.carouselView addSubview:view];
        int j = 0;
        if ((int)seller.starLevelId>5) {
            j = 0;
        }
        if ((int)seller.starLevelId == 5) {
            j = 1;
        }
        if ((int)seller.starLevelId == 4) {
            j = 2;
        }
        if ((int)seller.starLevelId == 3) {
            j = 3;
        }
        if ((int)seller.starLevelId == 2) {
            j = 4;
        }
        if ((int)seller.starLevelId == 1) {
            j = 5;
        }
        for (int i=0; i<j; i++) {
            CGFloat imageX = 0.0;
            imageX = i * 20 +15;
            UIImageView *starView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, 8, 20, 12)];
            starView.image = [UIImage imageNamed:@"star2"];
            [view addSubview:starView];
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(UI_CURRENT_SCREEN_WIDTH*0.88, 8, 30, 12)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        if (strA.count > 0) {
            label.text = [NSString stringWithFormat:@"%d/%ld",self.currentPosition,strA.count];
        }
        if (strA.count == 0) {
            [strA addObject:@""];
        }
        
        if (strA.count > 1) {
            [strA insertObject:strA[strA.count - 1] atIndex:0];
            [strA addObject:strA[1]];
        }
        self.strA = strA;
        
        for (int i = 0; i <  self.strA.count; i++) {
            CGFloat imageX = i * imageW;
            UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            NSString * picPath =  self.strA[i];
            [carouselImg sd_setImageWithURL:[NSURL URLWithString:picPath] placeholderImage:[UIImage imageNamed:@"icon72"]];
            [self.carouselView.scrView addSubview:carouselImg];
        }
        
        CGFloat contentW = (self.strA.count) *imageW;
        self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
        self.carouselView.scrView.contentOffset = CGPointMake(imageW, 0);
        [self addTimer];
    }];
    self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
    
}

- (void)msgChange {
    self.lblAdress.text = self.fullName;
    [self.lblAdress sizeToFit];
    CGRect frame = self.lblAdress.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width-100;
//    [UIScreen mainScreen].bounds.size.width;
    self.lblAdress.frame = frame;
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];
    frame = self.lblAdress.frame;
    frame.origin.x = -frame.size.width;
    self.lblAdress.frame = frame;
    [UIView commitAnimations];
}

/** 点击详情 */
- (IBAction)clickDetail:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgencyDetail" bundle:nil];
    NTGAgencyDetailVC *agencyDetailController = [storyboard instantiateInitialViewController];
    
    agencyDetailController.seller = self.seller;
    [self.navigationController pushViewController:agencyDetailController animated:YES];
}

//机构地址
- (IBAction)showAddressAction:(id)sender {
    NTGAgencyLocation *locationVC = [[NTGAgencyLocation alloc] init];
    locationVC.address = self.seller.area.fullName;
    [self.navigationController pushViewController:locationVC animated:NO];
}

/** 用户点评 */
- (IBAction)clickReviews:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGComment" bundle:nil];
    NTGCommentController *commentController = [storyboard instantiateInitialViewController];
    commentController.id = self.seller.id;
    commentController.tag = 10;
    [self.navigationController pushViewController:commentController animated:YES];
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(NTGAgencyGuestRoom *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGAgencyGuestRoom *cell =[tableView dequeueReusableCellWithIdentifier:@"agencyDetailCell"];
    cell.isShow = self.isShow;
    cell.product = self.sellers[indexPath.row];
    [cell.bookBtn addTarget:self action:@selector(bookBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

/** 房间预订 */
- (void)bookBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NTGAgencyGuestRoom *cell = (NTGAgencyGuestRoom *)btn.superview.superview;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGInstitutionOrder" bundle:nil];
    NTGInstitutionOrderController *institutionOrderController = [storyboard instantiateInitialViewController];
    institutionOrderController.product = cell.product;
    institutionOrderController.seller = self.seller;
    [self.navigationController pushViewController:institutionOrderController animated:YES];
}

/** 定时器 绑定的方法 */
- (void)switchHeadPosition:(UIScrollView *)scrollView {
        int currentPage = self.currentPosition;
        CGFloat scrollW = self.carouselView.scrView.frame.size.width;
        CGFloat scrollH = self.carouselView.scrView.frame.size.height;
        [self.carouselView.scrView setContentOffset:CGPointMake(scrollW * currentPage, 0)];
        [self.carouselView.scrView scrollRectToVisible:CGRectMake(scrollW* currentPage,0,scrollW,scrollH) animated:YES];
        int nextPostion = self.currentPosition++;
        if( nextPostion == self.strA.count - 1 ) {
           self.currentPosition = 0;
        }
}

/** 将要停止拖拽的时候调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        CGFloat offset = self.carouselView.scrView.contentOffset.x;
        CGFloat scrollW = self.carouselView.frame.size.width;
        int page = offset/scrollW - 1;
        
        if (offset == 0) {
            self.carouselView.scrView.contentOffset = CGPointMake(scrollW*(self.strA.count-2), 0);
            page = (int)self.strA.count - 1;
        }
        if (offset == scrollW * (self.strA.count - 1)) {
            self.carouselView.scrView.contentOffset = CGPointMake(scrollW, 0);
            page = 0;
        }
        self.carouselView.pageControl.currentPage = page;
    
}

/** 头部广告  开始拖拽的时候调用 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

/** 添加定时器 */
- (void)addTimer {
    self.carouselView.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(switchHeadPosition:) userInfo:nil repeats:YES];
}

/** 关闭定时器 */
- (void)removeTimer {
    [self.carouselView.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
