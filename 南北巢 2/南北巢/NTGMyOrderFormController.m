/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMyOrderFormController.h"
#import "NTGOrderListController.h"

/**
 * control - 我的订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMyOrderFormController ()

@end

@implementation NTGMyOrderFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 订单列表 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UIButton *btn = (UIButton *)sender;
    NTGOrderListController *orderListController = segue.destinationViewController;
    NSDictionary *dict = nil;
    if ([segue.identifier isEqualToString:@"productOrder"]) {
        dict = @{@"_title_":@"老年商品订单列表",@"orderType":@"productOrder"};
    }else if ([segue.identifier isEqualToString:@"guestRoomOrder"]) {
        dict = @{@"_title_":@"机构客房订单",@"orderType":@"guestRoomOrder"};
    }else if ([segue.identifier isEqualToString:@"travelOrder"]) {
        dict = @{@"_title_":@"老年游订单列表",@"orderType":@"travelOrder"};
    }
    orderListController.param = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
