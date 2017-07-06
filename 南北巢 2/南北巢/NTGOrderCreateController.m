/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderCreateController.h"
#import "NTGSendRequest.h"
#import "NTGBankCardListController.h"
#import "NTGMyOrderFormController.h"

/**
 * control - 确认购买
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderCreateController ()
/** 应付金额 */
@property (weak, nonatomic) IBOutlet UILabel *amountPayable;
/** 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *lblSns;
//订单号
@property (nonatomic,strong) NSString *sn;
@end

@implementation NTGOrderCreateController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    NSArray *childControllers = [tabbarController childViewControllers];
//    tabbarController.selectedViewController = childControllers[4];
////    [self.navigationController popToRootViewControllerAnimated:YES];
//    NTGMyOrderFormController *myOrderFormController = tabbarController.selectedViewController;
//    [self.navigationController pushViewController:myOrderFormController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"";
    self.amountPayable.text = [str stringByAppendingString:self.strTile];
    if (self.orderSn) {
        self.lblSns.text = [NSString stringWithFormat:@"%ld请您在提交订单后24小时内完成支付，否则订单会自动取消",(long)[self.orderSn longLongValue]];
    }else {
        [self initData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initData {
    NSString *str = [self.ids componentsJoinedByString:@","];
   
    NSDictionary *dict = @{
                           @"ids":str,
                           @"cartToken":self.cartToken,
                           @"receiverId":self.receiverId,
                           @"paymentMethodId":self.paymentMethodId,
                           @"shippingMethodId":self.shippingMethodId
                           };
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSString *num) {
//        int n = [num longValue];
        self.sn = num;
        self.lblSns.text = [NSString stringWithFormat:@"%@请您在提交订单后24小时内完成支付，否则订单会自动取消",num];
    };
    [NTGSendRequest getOrderCreate:dict success:result];
}

- (IBAction)bankCardList:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGBankCardList" bundle:nil];
    NTGBankCardListController *bankCardListController = [storyboard instantiateInitialViewController];
    bankCardListController.sn = [NSString stringWithFormat:@"%@",self.sn];
    [self.navigationController pushViewController:bankCardListController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
