/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGNanBeiPensionController.h"
#import "NTGSendRequest.h"
#import "NTGPensionAgencyTableView.h"
#import "NTGHotSalePosition.h"
#import "NTGPage.h"
#import "NTGHotCity.h"
#import "NTGClassCategoryController.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
#import "NTGProductSellerAttrWrapper.h"

/**
 * control - 南北养老机构
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGNanBeiPensionController ()

/** 城市列表视图 */
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cityViewH;
/** 城市列表 */
@property (nonatomic,strong) UIButton *btn;

/** 城市列表 */
@property (nonatomic,strong) NSMutableArray *attr;

/** 记录热门机构是否已加载完成 */
@property(nonatomic,assign) BOOL hotLoadFinish;
@end

@implementation NTGNanBeiPensionController

/** 退出控制器 */
- (IBAction)backBtn:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"南北养老";
    [self loadHotCity];
    
}

- (void) loadHotCity {
    [NTGSendRequest getHotCity:nil success:^(NTGPage *page) {
        int co = (int)page.content.count;
        if (co <=5 ) {
            self.cityViewH.constant = 41;
        }
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        CGFloat margin = 1;
        CGFloat w = (W-30-margin*6)/5;
        CGFloat h = 35;
        CGFloat y = 0;
        self.attr = [NSMutableArray array];
        NSDictionary *dict = nil;
        for (int i=0; i<co; i++) {
            self.btn = [[UIButton alloc]init];
            if (i<=4) {
                self.btn.frame = CGRectMake(i*(w+margin)+margin+15, y, w, h);
            }
            if (i>4) {
                y = h + 1;
                self.btn.frame = CGRectMake((i-5)*(w+margin)+margin+15, y, w, h);
            }
            NTGHotCity *hotCity = page.content[i];
            self.btn.tag = i;
            [self.btn setTitle:hotCity.name forState:UIControlStateNormal];
            [self.btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            self.btn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.btn.backgroundColor = [UIColor whiteColor];
            NSString *str = [NSString stringWithFormat:@"%ld",hotCity.areaId];
            dict = @{@"rootAreaId":str,@"_categoryNav_":@"养老机构"};
            [self.attr addObject:dict];
            [self.btn addTarget:self action:@selector(customButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.cityView addSubview:self.btn];
        }
    }];
}

/** 更新数据 */
- (void)initData:(NTGPullRefresh)action{
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown ) {
        [self.reqParam setObject:@"12" forKey:@"hotsaleNo"];
        [NTGSendRequest getHotSaleInstitutionList:self.reqParam success:^(NTGHotSalePosition *hotsellers) {
            [self updateTableView:hotsellers.hotSaleSellers action:action state:YES];
        }];
    }else {
        [NTGSendRequest getWrapperInstitutionAttrList:self.reqParam requestAddr:@"/app/institution/list.jhtml" successBack: ^(NTGProductSellerAttrWrapper *sellerAttrWrapper) {
            NSArray * institution = sellerAttrWrapper.page.content;
            //暂时只使用数据，未对列查询做处理
             [self updateTableView:institution action:action state:YES];
        }];
    }
}



- (IBAction)checkMore:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassCategory" bundle:nil];
    NTGClassCategoryController *classCategoryController = [storyboard instantiateViewControllerWithIdentifier:@"classCategoryController"];
    classCategoryController.reqParam = [NSMutableDictionary dictionary];
    [classCategoryController.reqParam setValue:@"养老机构" forKey:@"_categoryNav_"];
    [self.navigationController pushViewController:classCategoryController animated:YES];
}

/** 点击跳转控制器 */
- (void)customButton:(UIButton *)button {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassCategory" bundle:nil];
    NTGClassCategoryController *classCategoryController = [storyboard instantiateViewControllerWithIdentifier:@"classCategoryController"];
        classCategoryController.reqParam = self.attr[button.tag];
        [self.navigationController pushViewController:classCategoryController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
