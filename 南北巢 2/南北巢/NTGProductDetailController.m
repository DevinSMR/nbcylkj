/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDK/ShareSDK.h>
#import "NTGProductDetailController.h"
#import "NTGSendRequest.h"
#import "NTGProductContent.h"
#import "NTGProductContainer.h"
#import <UIImageView+WebCache.h>
#import "NTGProductImage.h"
#import "NTGRecommendTableView.h"
#import "NTGRecommend.h"
#import "NTGPage.h"
#import "NTGCommentController.h"
#import "EQPageCycleSize.h"
#import "NTGProductIntroductionController.h"
#import "NTGParameterController.h"
#import "NTGMBProgressHUD.h"
#import "NTGCart.h"
#import "NTGShoppingCartController.h"
#import "NTGLoginController.h"
#import "NTGCarouselView.h"
#import "NTGSpecification.h"
#import "NTGSpecificationValueBean.h"
#import "NTGSelectSpecificationValue.h"
#import "NTGSpecificationValueCell.h"
#import "NTGOrderInfoController.h"
#import "NTGShareView.h"
//#import "NTGSpecificationBean.h"
//#import "NTGSpecificationTable.h"

/**
 * control - 商品详情
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGProductDetailController ()<NTGRecommendTableViewDelegate,UIScrollViewDelegate>
/** 商品评论 */
@property (weak, nonatomic) IBOutlet UILabel *scoreCount;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UIView *headV;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblMarketPrice;
/** 推荐列表 */
@property (strong, nonatomic) NTGRecommendTableView *recommendView;
/** 滚动视图最大高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrH;
/** 购物车数量 */
@property (weak, nonatomic) IBOutlet UILabel *lblCartCount;
@property (nonatomic,strong) NTGCarouselView *carouselView;
@property(nonatomic,assign) int currentPosition;
/** 图片地址数组 */
@property (nonatomic,strong) NSArray *strA;
@property (nonatomic,strong) NTGSpecification *specification;
@property (nonatomic,strong)NTGProductContent *productS;
@property (nonatomic,assign) int temp;

@property (weak, nonatomic) IBOutlet UIView *navView;

//收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
//收藏按钮文字
@property (weak, nonatomic) IBOutlet UILabel *saveLb;

//购买商品数量
@property (nonatomic,strong) NSString *proCount;

//
@property (weak, nonatomic) IBOutlet UILabel *choseCountLb;


@property (nonatomic,strong) NTGShareView *shareView;
@end

@implementation NTGProductDetailController


- (IBAction)backTOAction:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:self.navView];
    
    self.proCount = @"1";
    self.temp = 1;
    [self.recommendView setBackgroundColor:[UIColor clearColor]];
    self.recommendView.delegateRec = self;
    [self initData];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [NTGSendRequest getCartList:nil success:^(NTGCart *cart) {
        self.lblCartCount.text = [NSString stringWithFormat:@"%d",cart.quantity];
        
    }];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}

- (void)initData {
    NSString *appPath = nil;
    if (_product != nil) {
        appPath = _product.path;
    }
    self.carouselView = [NTGCarouselView viewWithView];
    self.carouselView.frame = CGRectMake(0, 0, UI_CURRENT_SCREEN_WIDTH, 270);
    self.carouselView.scrView.bounces = NO;
    self.carouselView.scrView.pagingEnabled = YES;
    self.carouselView.scrView.delegate = self;
    [self.headV addSubview:self.carouselView];

    [NTGSendRequest getProductDetail:nil requestAddr:appPath successBack:^(NTGProductContainer *productContainer) {
        self.productS = productContainer.product;
        CGFloat imageW = self.carouselView.scrView.frame.size.width;
        CGFloat imageH = self.carouselView.scrView.frame.size.height;
        CGFloat imageY = 0;
        if (productContainer.product.productImages.count>0) {
            NSMutableArray *strA = [NSMutableArray arrayWithArray:productContainer.product.productImages];
            if (strA.count == 0) {
                [strA addObject:@""];
            }
            if (strA.count > 1) {
                [strA insertObject:strA[strA.count - 1] atIndex:0];
                [strA addObject:strA[1]];
            }
            if (strA.count == 1) {
                [strA insertObject:strA[strA.count - 1] atIndex:0];
                [strA addObject:strA[1]];

            }
            self.strA = strA;
            for (int i = 0; i <  self.strA.count; i++) {
                CGFloat imageX = i * imageW;
                UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
                
                NTGProductImage *productImage =  self.strA[i];
                NSString *picPath = nil;
                
                picPath = productImage.medium;
                [carouselImg sd_setImageWithURL:[NSURL URLWithString:picPath] placeholderImage:[UIImage imageNamed:@"icon72"]];
                
                [self.carouselView.scrView addSubview:carouselImg];
                
            }
            CGFloat contentW = (self.strA.count) *imageW;
            self.carouselView.scrView.contentSize = CGSizeMake(contentW, 0);
            self.carouselView.scrView.contentOffset = CGPointMake(imageW, 0);
            
        }else {
            UIImageView *carouselImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageY, imageW, imageH)];
            [carouselImg sd_setImageWithURL:[NSURL URLWithString:productContainer.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
            
            [self.carouselView.scrView addSubview:carouselImg];
        }
    
        NTGProductContent *product = productContainer.product;
        self.lblName.text = productContainer.product.name;
        self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[product.price floatValue]];
        self.lblMarketPrice.text = [NSString stringWithFormat:@"￥%.2f",[product.marketPrice floatValue]];
        self.scoreCount.text = [NSString stringWithFormat:@"%ld人评论",product.scoreCount];
        NSUInteger length = [self.lblMarketPrice.text length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.lblMarketPrice.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(2, length-2)];
        [self.lblMarketPrice setAttributedText:attri];
        if (self.count) {
            self.lblCartCount.text = [NSString stringWithFormat:@"%d",self.count];
        }else {
            self.lblCartCount.text = [NSString stringWithFormat:@"%ld",productContainer.cartCount];
        }
        NSString *str = [NSString stringWithFormat:@"%ld",product.productCategory.id];
        
        NSDictionary *dict = @{@"productCategoryId":str,@"pageNumber":@"1",@"pageSize":@"6"};
        [NTGSendRequest getProductRandom:dict successBack:^(NTGPage *page) {
            self.recommendView.products = page.content;
        }];
        
        //判断是否已经收藏过
        NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
        NSString *userID = [defults objectForKey:@"ID"];
        BOOL isSave = NO;
        for (NSNumber *ID in product.favoriteMemberIds) {
            if ([ID isEqualToNumber:@([userID longLongValue])]) {
                isSave = YES;
            }
        }
        if (product.favoriteMemberIds.count >0 && isSave) {
            self.saveBtn.selected = YES;
            self.saveLb.textColor = [UIColor colorWithRed:251/255.0 green:59/255.0 blue:13/255.0 alpha:1];}
    }];
    self.carouselView.scrView.showsHorizontalScrollIndicator = NO;
    if (self.strA.count>0) {
        [self addTimer];
    }
}

/** 收藏 */
- (IBAction)favoriteAdd:(id)sender {
    NSDictionary *dict= @{@"productId":[NSString stringWithFormat:@"%ld",self.product.id]};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(id responseObject) {
        self.saveBtn.selected = YES;
        self.saveLb.textColor = [UIColor colorWithRed:251/255.0 green:59/255.0 blue:13/255.0 alpha:1];
        [NTGMBProgressHUD alertView:@"收藏成功" view:self.view];
    };
    [NTGSendRequest favoriteAdd:dict success:result];
    if (self.saveBtn.selected) {
        [NTGMBProgressHUD alertView:@"您已收藏过此商品" view:self.view];
    }
}

/** 商品参数 */
- (IBAction)parameterBrn:(id)sender {
    if (self.product.paramValue.count != 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGParameter" bundle:nil];
        NTGParameterController *parameterController = [storyboard instantiateInitialViewController];
        parameterController.paramValue = self.product.paramValue;
        [self.navigationController pushViewController:parameterController animated:YES];
    }else {
        [NTGMBProgressHUD alertView:@"没有参数!" view:self.view];
    }
}

/** 商品介绍 */
- (IBAction)introductionBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductIntroduction" bundle:nil];
    NTGProductIntroductionController *productIntroduction = [storyboard instantiateInitialViewController];
    productIntroduction.intro = self.product.introduction;
    [self.navigationController pushViewController:productIntroduction animated:YES];
}

/** 用户评论 */
- (IBAction)commentBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGComment" bundle:nil];
    NTGCommentController *commentController = [storyboard instantiateInitialViewController];
    commentController.id = [NSString stringWithFormat:@"%ld",self.product.id];
    [self.navigationController pushViewController:commentController animated:YES];
}

/** 选择商品规格尺寸 */
- (IBAction)specificationBtn:(id)sender {
    
    [self choseSpecification];
    
}


-(void)choseSpecification{
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%ld",self.productS.id] forKey:@"productId"];
    NSString *delStr = @"";
    if (self.productS.specificationValues) {
        for (int i=0; i<self.productS.specificationValues.count; i++) {
            NTGSpecificationValueBean *specificationValue = self.productS.specificationValues[i];
            if (![delStr isEqualToString:@""]) {
                delStr = [delStr stringByAppendingString:@","];
            }
            delStr = [delStr stringByAppendingString:[NSString stringWithFormat:@"%ld",specificationValue.id]];
        }
        [dict setValue:delStr forKey:@"selectedIds"];
    }
//    if ([[dict valueForKey:@"selectedIds"] isEqualToString:@""]) {
//        [NTGMBProgressHUD alertView:@"此商品无货!" view:self.view];
//        return;
//    }
    if (self.productS.stock == 0) {
        [NTGMBProgressHUD alertView:@"此商品无货!" view:self.view];
        return;
    }

    self.specification = [NTGSpecification viewWithView];
    self.specification.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.specification];
    
    
    [self.specification.backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.specification.minusBtn addTarget:self action:@selector(plusminis:) forControlEvents:UIControlEventTouchUpInside];
    [self.specification.plusBtn addTarget:self action:@selector(plusminis:) forControlEvents:UIControlEventTouchUpInside];
    [self.specification.ensureBtn addTarget:self action:@selector(ensureAction) forControlEvents:UIControlEventTouchUpInside];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseSizeAndColor:) name:@"tongzhi" object:nil];
    
    self.specification.specificationTable.countBlock = ^(NSString *count){
        self.proCount = count;
    };
    [self loadData:dict];
}


/** 点击加号减号编辑购物车商品数量 */
- (void)plusminis:(UIButton *)btn {
    if (btn.tag == 100) {
        if (self.temp <= 1) {
            [self.specification.minusBtn setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
        }else if (self.temp > 1) {
            self.temp--;
            self.specification.lblCount.text = [NSString stringWithFormat:@"%d",self.temp];
            [self.specification.minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if ([self.specification.lblCount.text intValue] == 1) {
                [self.specification.minusBtn setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
    }
    if (btn.tag == 200) {
        self.temp++;
        self.specification.lblCount.text = [NSString stringWithFormat:@"%d",self.temp];
        [self.specification.minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

}

//* 选中按钮
- (void)chooseSizeAndColor:(NSNotification *)sender {
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%ld",self.productS.id] forKey:@"productId"];
    NSString *delStr = @"";
    UIButton *btn = (UIButton *)[sender.userInfo valueForKey:@"1"];
    
    if (btn.selected) {
        if (![delStr isEqualToString:@""]) {
            delStr = [delStr stringByAppendingString:@","];
        }
        delStr = [delStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }

    NSArray *cells = self.specification.specificationTable.visibleCells;
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:cells];
    [tempArr removeLastObject];
    cells = tempArr;
    NSLog(@"%@",cells);
    
    for (int i=0; i<cells.count; i++) {
        NTGSpecificationValueCell *cell = (NTGSpecificationValueCell *)[sender.userInfo valueForKey:@"2"];
        NTGSpecificationValueCell *otherCell = cells[i];
        
        if (![cell.specificationBean isEqual:otherCell.specificationBean]) {
            NTGSpecificationBean *specificationBean = otherCell.specificationBean;
            NSArray *specificationValues = specificationBean.specificationValues;
            for (int j=0; j<specificationValues.count; j++) {
                NTGSpecificationValueBean *specificationValue = specificationValues[j];
                if (specificationValue.isSelected) {
                    if (![delStr isEqualToString:@""]) {
                        delStr = [delStr stringByAppendingString:@","];
                    }
                    delStr = [delStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)specificationValue.id]];
                }
            }
        }
    }

    [dict setValue:delStr forKey:@"selectedIds"];
    
    [self loadData:dict];
}

- (void)loadData:(NSMutableDictionary *)dict {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGSelectSpecificationValue *selectSpecificationValue) {
        self.product.id = selectSpecificationValue.product.id;
        self.specification.specificationTable.effectiveSpecifications = selectSpecificationValue.effectiveSpecifications;
        self.specification.stock.text = [NSString stringWithFormat:@"库存%ld件",selectSpecificationValue.product.stock];
        [self.specification.iconView sd_setImageWithURL:[NSURL URLWithString:selectSpecificationValue.product.thumbnail] placeholderImage:[UIImage imageNamed:@"icon72"]];
        self.specification.price.text = [NSString stringWithFormat:@"%.2f",[selectSpecificationValue.product.price floatValue]];
    };
    
    [NTGSendRequest selectSpecificationValue:dict success:result];
}

/** 删除 */
- (void)backBtn {
    [self.specification removeFromSuperview];
}

/** 选中代理方法 */
-(void)clickindexPathRow:(NTGProductContent *)product index:(int)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductDetail" bundle:nil];
    NTGProductDetailController *productDetailController = [storyboard instantiateInitialViewController];
    productDetailController.product = self.recommendView.products[index];
    [self.navigationController pushViewController:productDetailController animated:YES];
}
//跳转到购物车页面
- (IBAction)goToCartVCAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Shopping" bundle:nil];
    NTGShoppingCartController *cartController = [storyboard instantiateInitialViewController];
    cartController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cartController animated:YES];
    
}

/** 加入购物车 */
- (IBAction)addCart:(id)sender {
    self.specification.isNowBuy = NO;
    [self choseSpecification];
}

//立即购买
- (IBAction)buyNowAction:(id)sender {
    
    [self choseSpecification];
    self.specification.isNowBuy = YES;
}

-(void)ensureAction{
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if ([isLogin isEqualToString:@"0"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGLogin" bundle:nil];
        NTGLoginController *loginController = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }

    if (self.specification.isNowBuy == YES) {

        
        NSDictionary *dicts = @{@"productId":[NSString stringWithFormat:@"%ld",self.product.id],@"buyQuantity":self.proCount};
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(NTGCart *cart) {
            NSString *productId = [NSString stringWithFormat:@"%ld",self.product.id];
            NSDictionary *dict = @{@"ids":productId,@"buyQuantity":self.proCount};
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGOrderInfo" bundle:nil];
            NTGOrderInfoController *cartInfoController = [storyboard instantiateInitialViewController];
            cartInfoController.dict = dict;
            cartInfoController.ids = @[productId];
            [self.navigationController pushViewController:cartInfoController animated:YES];
        };
        [NTGSendRequest getAddCart:dicts success:result];


        
    }else{
    
        [self addCartBtn];
    
    }


}

- (void)addCartBtn {
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if ([isLogin isEqualToString:@"0"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGLogin" bundle:nil];
        NTGLoginController *loginController = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }
    NSDictionary *dict = @{@"productId":[NSString stringWithFormat:@"%ld",self.product.id],@"buyQuantity":self.proCount};
    [self addCartWithDict:dict];
    
}

- (void)addCartWithDict:(NSDictionary *)dict {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGCart *cart) {
        self.choseCountLb.text = [NSString stringWithFormat:@"已选%@件",self.proCount];
        self.lblCartCount.text = [NSString stringWithFormat:@"%d",cart.quantity];
        [self.specification removeFromSuperview];
    };
    [NTGSendRequest getAddCart:dict success:result];
}

/** 购物车列表 */
- (IBAction)ShoppingCart:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Shopping" bundle:nil];
//    NTGShoppingCartController *cartController = [storyboard instantiateInitialViewController];
//    cartController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cartController animated:YES];
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
        self.carouselView.scrView.contentOffset = CGPointMake(scrollW*((int)self.strA.count-2), 0);
        page = (int)self.strA.count-1 ;
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

- (IBAction)shareAction:(id)sender {
    
    NTGShareView *view = [NTGShareView viewWithView];
    view.frame = self.view.frame;
    
    self.shareView = view;
    [self.view addSubview:self.shareView];
    [self.view bringSubviewToFront:self.shareView];
    
    [view.cancleBtn addTarget:self action:@selector(removeShareView) forControlEvents:UIControlEventTouchUpInside];
    [view.qqBtn addTarget:self action:@selector(shareToQQ) forControlEvents:UIControlEventTouchUpInside];
    [view.weiboBtn addTarget:self action:@selector(shareToWeibo) forControlEvents:UIControlEventTouchUpInside];
    [view.wechatBtn addTarget:self action:@selector(shareToWechat) forControlEvents:UIControlEventTouchUpInside];
    [view.penyouBtn addTarget:self action:@selector(shareToPengyou) forControlEvents:UIControlEventTouchUpInside];
    [view.QzoneBtn addTarget:self action:@selector(shareToQZone) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)shareToQQ{
    //创建分享参数
    [self shareToSubType:SSDKPlatformTypeQQ];
     
}
-(void)shareToQZone{
    //创建分享参数
    [self shareToSubType:SSDKPlatformSubTypeQZone];
    
}

-(void)shareToWechat{
    //创建分享参数
    [self shareToSubType:SSDKPlatformTypeWechat];
    
}

-(void)shareToPengyou{
    //创建分享参数
    [self shareToSubType:SSDKPlatformSubTypeWechatTimeline];
    
}

-(void)shareToWeibo{
    
    // 定制新浪微博的分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupSinaWeiboShareParamsByText:@"定制新浪微博的分享内容"                                       title:nil
                                               image:[UIImage imageNamed:@"share_qq"]
                                                 url:nil
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 NSString *errorStr = @"抱歉，需要安装微博客户端才能分享！";
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:errorStr
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }
     }];

    //创建分享参数
   // [self shareToSubType:SSDKPlatformTypeSinaWeibo];
    
}



-(void)shareToSubType:(SSDKPlatformType)type{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];

    [shareParams SSDKSetupShareParamsByText:@"来不及解释了快上车"
                                     images:[UIImage imageNamed:@"share_qq"] //传入要分享的图片
                                        url:[NSURL URLWithString:@"www.baidu.com"]
                                      title:@"开车啦"
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 [self removeShareView];
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 NSString *errorStr = @"抱歉，需要安装客户端才能分享！";
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:errorStr
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }
     }];
}

-(void)removeShareView{
    
    [self.shareView removeFromSuperview];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
