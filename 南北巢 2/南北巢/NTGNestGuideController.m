/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGNestGuideController.h"
#import "NTGSendRequest.h"
#import "EQPageCycleSize.h"
#import "NTGCarouselView.h"
#import "NTGScenicRegion.h"
#import "NTGScenicRegionContent.h"
#import <UIImageView+WebCache.h>
#import "NTGIntroductionView.h"
#import "NTGCommentView.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 巢友指南详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGNestGuideController ()<UIScrollViewDelegate,UIWebViewDelegate>

/** 景区名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 景区介绍按钮 */
@property (weak, nonatomic) IBOutlet UIButton *introductionBtn;
/** 门票信息按钮 */
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
/** 交通信息按钮 */
@property (weak, nonatomic) IBOutlet UIButton *trafficBtn;
/** 评论说说按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 景区介绍滚动条 */
@property (weak, nonatomic) IBOutlet UIView *introductionView;
/** 门票信息滚动条 */
@property (weak, nonatomic) IBOutlet UIView *ticketView;
/** 交通信息滚动条 */
@property (weak, nonatomic) IBOutlet UIView *trafficView;
/** 评论说说滚动条 */
@property (weak, nonatomic) IBOutlet UIView *commentView;
/** 滚动内视图 */
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (nonatomic,strong) NTGCarouselView *carouselView;
@property (nonatomic,strong) NTGIntroductionView *introView;
@property (nonatomic,strong) NTGCommentView *comView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureConstraint;

//scollView上View的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *superViewConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introViewBottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UIScrollView *superScrollView;

/** 图片地址数组 */
@property (nonatomic,strong) NSArray *strA;
@property(nonatomic,assign) int currentPosition;
@end

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
@implementation NTGNestGuideController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addViews];
    [self setUpSuperViewHeight];
//    self.introView.webView.scrollView.bounces = NO;
    self.introView.webView.scrollView.delegate = self;
    self.introView.webView.scrollView.tag = 20001;
    self.introView.webView.delegate = self;

    [self.introView.webView sizeToFit];

    [self.introView.webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
    self.navigationItem.title = self.headLine;
}

//设置父视图的高度
-(void) setUpSuperViewHeight{
    CGFloat  screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight == 568) {
        self.superViewConstraintH.constant = 789;
        self.introViewBottomConstraint.constant = -65;
        
    }else if (screenHeight == 667){
    
        self.superViewConstraintH.constant = 888;
        self.introViewBottomConstraint.constant = -65;
    }
    else if (screenHeight == 736){
    
        self.superViewConstraintH.constant = 957;
        self.introViewBottomConstraint.constant = -65;

    
    }
    
    
}



-(void)updateViewConstraints{
    [super updateViewConstraints];
}

-(void)changeContraint{
    self.carouselView.hidden = YES;
    self.pictureConstraint.constant = 24;
    [self updateViewConstraints];


}

- (void)initData {
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, 0, UI_CURRENT_SCREEN_WIDTH, 240);
    self.carouselView.scrView.bounces = NO;
    self.carouselView.scrView.pagingEnabled = YES;
    self.carouselView.scrView.delegate = self;
    [self.superView addSubview:self.carouselView];

    [self.introView.webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
    [self.introductionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"/app/nestguide/content/%ld.jhtml",self.scenicRegion.id];
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGScenicRegionContent *scenicRegionContent) {
        self.scenicRegion = scenicRegionContent.scenicRegion;
        self.lblName.text = self.scenicRegion.name;
        self.comView.memberComments = scenicRegionContent.memberComments.content;
        NSMutableArray *strA = [NSMutableArray array];
        NSString *str1 = scenicRegionContent.scenicRegion.scenicRegionImage1;
        NSString *str2 = scenicRegionContent.scenicRegion.scenicRegionImage2;
        NSString *str3 = scenicRegionContent.scenicRegion.scenicRegionImage3;
        NSString *str4 = scenicRegionContent.scenicRegion.scenicRegionImage4;
        NSString *str5 = scenicRegionContent.scenicRegion.scenicRegionImage5;
        NSString *str6 = scenicRegionContent.scenicRegion.scenicRegionImage6;
         NSString *str7 = scenicRegionContent.scenicRegion.scenicRegionImage7;
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
        if (str7 != nil) {
            [strA addObject:str7];
        }
        
        if (strA.count == 0) {
            [strA addObject:@""];
        }
        
        if (strA.count > 1) {
            [strA insertObject:strA[strA.count - 1] atIndex:0];
            [strA addObject:strA[1]];
        }
        self.strA = strA;
        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        CGFloat imageH = self.carouselView.scrView.frame.size.height;
        CGFloat imageY = 0;
        for (int i = 0; i < self.strA.count; i++) {
            CGFloat imageX = i * imageW;
            UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            NSString * picPath =  self.strA[i];
            [carouselImg sd_setImageWithURL:[NSURL URLWithString:picPath] placeholderImage:[UIImage imageNamed:@"icon72"]];
//            UISwipeGestureRecognizer * recognizer;
//            recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeContraint)];
//            [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
//            carouselImg.userInteractionEnabled = YES;
//            [carouselImg addGestureRecognizer:recognizer];
////            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeContraint)];
////            [carouselImg addGestureRecognizer:tap];
            [self.carouselView.scrView addSubview:carouselImg];
        }
        
        CGFloat contentW = (strA.count + 2) *imageW;
        self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
        self.carouselView.scrView.contentOffset = CGPointMake(imageW, 0);
    };
    [NTGSendRequest nestguideContent:nil requestAddr:url success:result];
    self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
    [self addTimer];

}

/** 景点介绍 */
- (IBAction)introductionBtn:(id)sender {
    CGPoint contentOffset = CGPointMake(0, supScrViewOffSetY);
    [self.scrView setContentOffset:contentOffset animated:NO];
    self.introView.webView.hidden = !self.introView.webView.hidden;
    if (self.scenicRegion.introduction) {
        if (self.introView.webView.hidden) {
            self.introView.webView.hidden = NO;
        }
        [self.introView.webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
    }else {
        self.introView.webView.hidden = YES;
        [NTGMBProgressHUD alertView:@"没有数据！" view:self.view];
    }
    
    [self.introductionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.ticketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.trafficBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.introductionView.backgroundColor = [UIColor orangeColor];
    self.ticketView.backgroundColor = [UIColor whiteColor];
    self.trafficView.backgroundColor = [UIColor whiteColor];
    self.commentView.backgroundColor = [UIColor whiteColor];
}

/** 门票信息 */
- (IBAction)ticketBtn:(id)sender {
    CGPoint contentOffset = CGPointMake(0, supScrViewOffSetY);
    [self.scrView setContentOffset:contentOffset animated:NO];
    self.introView.webView.hidden = !self.introView.webView.hidden;
    if (self.scenicRegion.ticketInfo) {
        if (self.introView.webView.hidden) {
            self.introView.webView.hidden = NO;
        }
        [self.introView.webView loadHTMLString:self.scenicRegion.ticketInfo baseURL:nil];
    }else {
        self.introView.webView.hidden = YES;
        [NTGMBProgressHUD alertView:@"没有数据！" view:self.view];
    }
    [self.introductionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ticketBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.trafficBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.introductionView.backgroundColor = [UIColor whiteColor];
    self.ticketView.backgroundColor = [UIColor orangeColor];
    self.trafficView.backgroundColor = [UIColor whiteColor]; 
    self.commentView.backgroundColor = [UIColor whiteColor];
}

/** 交通信息 */
- (IBAction)trafficBtn:(id)sender {
    CGPoint contentOffset = CGPointMake(0, supScrViewOffSetY);
    [self.scrView setContentOffset:contentOffset animated:NO];
    self.introView.webView.hidden = !self.introView.webView.hidden;
    if (self.scenicRegion.trafficInfo) {
        if (self.introView.webView.hidden) {
            self.introView.webView.hidden = NO;
        }
        [self.introView.webView loadHTMLString:self.scenicRegion.trafficInfo baseURL:nil];
    }else {
        self.introView.webView.hidden = YES;
        [NTGMBProgressHUD alertView:@"没有数据！" view:self.view];
    }
    [self.introductionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ticketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.trafficBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.introductionView.backgroundColor = [UIColor whiteColor];
    self.ticketView.backgroundColor = [UIColor whiteColor];
    self.trafficView.backgroundColor = [UIColor orangeColor];
    self.commentView.backgroundColor = [UIColor whiteColor];
}

/** 评论说说 */
- (IBAction)commentBtn:(id)sender {
    [self.introductionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ticketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.trafficBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.introductionView.backgroundColor = [UIColor whiteColor];
    self.ticketView.backgroundColor = [UIColor whiteColor];
    self.trafficView.backgroundColor = [UIColor whiteColor];
    self.commentView.backgroundColor = [UIColor orangeColor];
    CGFloat imgW = self.view.bounds.size.width;
    CGPoint contentOffset = CGPointMake(imgW, supScrViewOffSetY);
    [self.scrView setContentOffset:contentOffset animated:NO];
    
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

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat kscreenWidth = [UIScreen mainScreen].bounds.size.width;
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
                                                     "script.type = 'text/javascript';"
                                                     "script.text = \"function ResizeImages() { "
                                                     "var myimg,oldwidth;"
                                                     "var maxwidth = %f;" // UIWebView中显示的图片宽度
                                                     "var maxheight = maxwidth*9/16.0;"
                                                     "for(i=0;i <document.images.length;i++){"
                                                     "myimg = document.images[i];"
                                                     "if(myimg.width > maxwidth){"
                                                     "oldwidth = myimg.width;"
                                                     "myimg.width = maxwidth;"
                                                     "myimg.height = maxheight;"
                                                     
                                                     "}"
                                                     "}"
                                                     "}\";"
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",kscreenWidth - 30]];
    //文本的对齐方式
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.textAlign = 'justify';"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];    //页面背景色
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F5F5F5'"];
    //    //字体大小
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '110%'"];//修改百分比即可
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('img')[%d].style.width = '100%'"];
    
    

}

static CGFloat supScrViewOffSetY = 0;
static CGFloat tempCurOffSetY = 0;
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//            NSLog(@"========%f",self.superScrollView.contentOffset.y);
//
//    if (scrollView.tag == 20001) {
//        // 获取当前偏移量y值
//        CGFloat curOffsetY = scrollView.contentOffset.y;
//
//        NSLog(@"========%f",curOffsetY);
//        if (curOffsetY > 0) {
////            if (curOffsetY < 235 && tempCurOffSetY < curOffsetY) {
////                self.superScrollView.contentOffset = CGPointMake(0, curOffsetY);
////            }
//            [self.superScrollView setContentOffset:CGPointMake(0, 235) animated:YES];
//            supScrViewOffSetY = 235;
//            NSLog(@"aaaaaa%@",self.introView.webView.frame);
//
//        }else{
//            if (curOffsetY < -60) {
//                [self.superScrollView setContentOffset:CGPointMake(0, -65) animated:YES];
//                supScrViewOffSetY = -65;
//            }
// 
//        }
//         tempCurOffSetY = curOffsetY;
//        
//    }
//    
//}

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

/** 准备界面 */
- (void)addViews{
    self.introView = [NTGIntroductionView viewWithView];
    self.comView = [NTGCommentView viewWithView];
    CGFloat imgW = self.view.bounds.size.width;
    CGFloat imgH = self.view.bounds.size.height-406;
    self.introView.frame = CGRectMake(0, 0, imgW, imgH);
    self.introView.frame = CGRectMake(0, 0, imgW, self.scrView.frame.size.height);
    self.comView.frame = CGRectMake(imgW, 0, imgW, self.scrView.frame.size.height);
    self.scrView.contentSize = CGSizeMake(2*imgW, 0);
    self.scrView.pagingEnabled = YES;
    self.scrView.showsHorizontalScrollIndicator = NO;
    self.scrView.showsVerticalScrollIndicator = NO;
    self.scrView.bouncesZoom = NO;
    self.scrView.bounces = NO;
    self.scrView.scrollEnabled = NO;
    self.scrView.delegate = self;

    
    self.introView.webView.userInteractionEnabled = YES;
    self.comView.userInteractionEnabled = YES;

//    UIView *intro = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imgW, self.scrView.frame.size.height)];
//   UIView *comment = [[UIView alloc] initWithFrame:CGRectMake(imgW, 0, imgW, self.scrView.frame.size.height)];
//    [intro addSubview:self.introView];
//    [comment addSubview:self.comView];
//    [self.scrView addSubview:intro];
//    [self.scrView addSubview:comment];
    
    [self.scrView addSubview:self.introView];
    [self.scrView addSubview:self.comView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
