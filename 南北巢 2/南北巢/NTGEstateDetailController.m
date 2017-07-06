/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGEstateDetailController.h"
#import "NTGSendRequest.h"
#import "EQPageCycleSize.h"
#import "NTGCarouselView.h"
#import "NTGElderlyEstateContent.h"
#import "NTGEstateRoomTypeCell.h"
#import "NTGRoomDetailController.h"
#import <UIImageView+WebCache.h>

/**
 * control - 地产详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGEstateDetailController ()<UIScrollViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
/** 详情界面 */
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
/** 详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
/** 头部滚动模块 */
@property (nonatomic,strong) NTGCarouselView *carouselView;
/** 户型展示 */
@property (weak, nonatomic) IBOutlet UITableView *roomTypeTable;
@property (weak, nonatomic) IBOutlet UIView *bgView;
/** 图片地址数组 */
@property (nonatomic,strong) NSArray *strA;
@property(nonatomic,assign) int currentPosition;
@end

@implementation NTGEstateDetailController

- (void)setProducts:(NSArray *)products {
    _products = products;
}

/** 退出控制器 */
- (void)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.roomTypeTable.dataSource = self;
    self.roomTypeTable.rowHeight = 180;
    self.viewH.constant = (self.products.count - 1) *180 + 600;
    [self.roomTypeTable reloadData];
    [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(msgChange) userInfo:nil repeats:YES];
    self.bgView.clipsToBounds = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)initData {
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, -20, UI_CURRENT_SCREEN_WIDTH, 300);
    self.carouselView.scrView.bounces = NO;
    self.carouselView.scrView.pagingEnabled = YES;
    self.carouselView.scrView.delegate = self;
    [self.scroll addSubview:self.carouselView];
//    [self.view addSubview:self.carouselView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"xqjg_activity"] forState:UIControlStateNormal];
    [self.carouselView addSubview:btn];
    [btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.products = self.project.roomTypeProduct;
    NSMutableArray *strA = [NSMutableArray array];
    NSString *str1 = self.project.projectImage7;
    NSString *str2 = self.project.projectImage2;
    NSString *str3 = self.project.projectImage3;
    NSString *str4 = self.project.projectImage4;
    NSString *str5 = self.project.projectImage5;
    NSString *str6 = self.project.projectImage6;
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
    
    if (strA.count == 0) {
        [strA addObject:@""];
    }
    
    if (strA.count > 1) {
        [strA insertObject:strA[strA.count - 1] atIndex:0];
        [strA addObject:strA[1]];
    }
    self.strA = strA;
    
    CGFloat imageW = self.view.frame.size.width;
    CGFloat imageH = self.carouselView.scrView.frame.size.height;
    CGFloat imageY = 0;
    for (int i = 0; i <  self.strA.count; i++) {
        CGFloat imageX = i * imageW;
        UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        NSString * picPath =  self.strA[i];
        [carouselImg sd_setImageWithURL:[NSURL URLWithString:picPath] placeholderImage:[UIImage imageNamed:@"icon72"]];
        [self.carouselView.scrView addSubview:carouselImg];
    }
    
    CGFloat contentW = ( self.strA.count) *imageW;
    self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
    self.carouselView.scrView.contentOffset = CGPointMake(imageW, 0);
    self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
    [self addTimer];
}

- (void)msgChange {
    NSString *str = [NSString stringWithFormat:@"%@%@",self.project.area.fullName,self.project.projectAddress];
    self.lblAddress.text = str;
//    self.lblAdress.text = self.fullName;
    [self.lblAddress sizeToFit];
    CGRect frame = self.lblAddress.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    //    [UIScreen mainScreen].bounds.size.width;
    self.lblAddress.frame = frame;
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];
    frame = self.lblAddress.frame;
    frame.origin.x = -frame.size.width;
    self.lblAddress.frame = frame;
    [UIView commitAnimations];
}

/** 地产详情 */
- (IBAction)estateDetailBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGRoomDetail" bundle:nil];
    NTGRoomDetailController *roomDetailController = [storyboard instantiateInitialViewController];
    roomDetailController.project = self.project;
    [self.navigationController pushViewController:roomDetailController animated:YES];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (NTGEstateRoomTypeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGEstateRoomTypeCell *cell = [NTGEstateRoomTypeCell cellWithTableView:tableView];
    cell.project = self.products[indexPath.row];
    return cell;
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
- (void)removeTimer
{
    [self.carouselView.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
