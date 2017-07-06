/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGClassificationController.h"
#import "EQPageCycleSize.h"
#import "NTGclassCell.h"
#import "NTGDockTableVIew.h"
#import "NTGRightTableVIew.h"
#import <MJExtension.h>
#import "NTGNetworkTool.h"
#import "NTGSendRequest.h"
#import "NTGClassCategoryController.h"
#import "NTGCategoryNavigation.h"
#import "NTGOldTravelController.h"
#import "NTGProductController.h"
#import "NTGElderlyEstateController.h"
#import "NTGInsuranceController.h"
#import "NTGSearchController.h"
#import "NTGMBProgressHUD.h"
#import "NTGElderlyFinanceController.h"

/**
 * control - 分类控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGClassificationController ()<NTGDockTavleViewDelegate
,NTGRightTavleViewDelegate>

/** 上方图片框 */
@property (weak, nonatomic) IBOutlet UIImageView *classImg;

/** 左侧结构 */
@property (weak, nonatomic) IBOutlet NTGDockTableVIew *docktable;

/** 右侧结构 */
@property (weak, nonatomic) IBOutlet NTGRightTableVIew *rightTable;

/** 记录点击左边某一行 */
@property (nonatomic,assign) int tag;
@end

@implementation NTGClassificationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES];
    self.docktable.delegateDock=self;
    self.rightTable.delegateRight = self;
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/** 网路访问 */
- (void)initData {
    [NTGSendRequest getCategoryNavigation:nil success:^(NSArray *responseObject) {
        self.docktable.categoryNavs = responseObject;
        NTGCategoryNavigation *m2 = responseObject[0];
        self.rightTable.categoryNavs = m2.children;
        
    }];
    self.classImg.image = [UIImage imageNamed:@"organization0"];
}

- (IBAction)searchBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGSearch" bundle:nil];
    NTGSearchController *searchController = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:searchController animated:YES];
}

#pragma  -make 代理
-(void)clickDockindexPathRow:(NTGCategoryNavigation *)classificationModel index:(NSIndexPath *)index {
    self.rightTable.categoryNavs= classificationModel.children;
    [self.rightTable reloadData];
    //图片重新载入
    self.classImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"organization%ld",(long)index.row]];
    self.tag = (int)index.row;
}

/** 代理方法 */
-(void)clickRightindexPathRow:(NTGCategoryNavigation *)categoryNav index:(int)index {
    if (self.tag == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassCategory" bundle:nil];
        NTGClassCategoryController *classCategoryController = [storyboard instantiateViewControllerWithIdentifier:@"classCategoryController"];
        classCategoryController.categoryNav = categoryNav;
        [self.navigationController pushViewController:classCategoryController animated:YES];
    }else if (self.tag == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"OldTravel" bundle:nil];
        NTGOldTravelController *oldTravelController = [storyboard instantiateViewControllerWithIdentifier:@"oldTravelController"];
        oldTravelController.categoryNav = categoryNav;
        [self.navigationController pushViewController:oldTravelController animated:YES];
    }else if (self.tag == 2 ) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProduct" bundle:nil];
        NTGProductController *productController = [storyboard instantiateViewControllerWithIdentifier:@"productController"];
        productController.categoryNav = categoryNav;
        [self.navigationController pushViewController:productController animated:YES];
    }else if (self.tag == 3) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProduct" bundle:nil];
        NTGProductController *productController = [storyboard instantiateViewControllerWithIdentifier:@"productController"];
        productController.categoryNav = categoryNav;
        [self.navigationController pushViewController:productController animated:YES];
    }else if (self.tag == 4) {
        if (index == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ElderlyEstate" bundle:nil];
            NTGElderlyEstateController *elderlyEstateController = [storyboard instantiateViewControllerWithIdentifier:@"elderlyEstateController"];
            elderlyEstateController.categoryNav = categoryNav;
            [self.navigationController pushViewController:elderlyEstateController animated:YES];
        }else if (index == 1) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Insurance" bundle:nil];
            NTGInsuranceController *insuranceController = [storyboard instantiateViewControllerWithIdentifier:@"insuranceController"];
            insuranceController.categoryNav = categoryNav;
            [self.navigationController pushViewController:insuranceController animated:YES];
        }else if (index == 2) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ElderlyFinance" bundle:nil];
            NTGElderlyFinanceController *elderlyFinanceController = [storyboard instantiateInitialViewController];
            [self.navigationController pushViewController:elderlyFinanceController animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
