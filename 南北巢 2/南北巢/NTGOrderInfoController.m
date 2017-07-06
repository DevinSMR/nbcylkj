/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderInfoController.h"
#import "NTGSendRequest.h"
#import "NTGOrderInfo.h"
#import "NTGMember.h"
#import "NTGOrder.h"
#import "NTGReceiverContent.h"
#import "NTGShippingMethod.h"
#import "NTGPaymentMethod.h"
#import "NTGCartInfoCell.h"
#import "NTGReceiverListController.h"
#import "NTGInvoiceController.h"
#import "NTGOrderCreateController.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 确认订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderInfoController ()<UITableViewDataSource>
/** 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *consignee;
/** 收货人电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 收货人详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *paymentMethods;
/** 发票抬头 */
@property (weak, nonatomic) IBOutlet UILabel *invoiceTitle;
/** 配送方式 */
@property (weak, nonatomic) IBOutlet UILabel *shippingMethodsName;
/** 总额 */
@property (weak, nonatomic) IBOutlet UILabel *amountPayable;
/** 会员 */
@property (nonatomic,strong) NTGMember *member;
/** 订单 */
@property (nonatomic,strong) NTGOrder *order;
/** 订单内容 */
@property (nonatomic,strong) NSArray *orderItems;
@property (weak, nonatomic) IBOutlet UITableView *orderTable;
@property (nonatomic,strong) NTGOrderInfo *orderInfo;
@property (nonatomic,copy) NSString *receiverId;
@property (nonatomic,copy) NSString *paymentMethodId;
@property (nonatomic,copy) NSString *shippingMethodId;
//收货地址列表数组
@property (nonatomic,strong) NSArray *receivers;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
//当前收货地址
@property (nonatomic,strong) NTGReceiverContent *receiver;
@end

@implementation NTGOrderInfoController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self.orderTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderTable.dataSource=self;
    self.orderTable.rowHeight = 80;
    [self initData];
    
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
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGOrderInfo *orderInfo) {
        self.orderInfo = orderInfo;
        self.member = orderInfo.member;
        self.order = orderInfo.order;
        self.orderItems = orderInfo.order.orderItems;
        self.viewH.constant = 440 + (self.orderItems.count-1) *80;
        self.receivers = self.member.receivers;
        for (int i=0; i<self.member.receivers.count; i++) {
            NTGReceiverContent *receiver = self.member.receivers[i];
            if (receiver.isDefault) {
                self.receiverId = [NSString stringWithFormat:@"%ld",receiver.id];
                self.consignee.text = receiver.consignee;
                self.phone.text = receiver.phone;
                self.address.text = [receiver.areaName stringByAppendingString:receiver.address];
            }
        }
        for (int j=0; j<orderInfo.paymentMethods.count; j++) {
            NTGPaymentMethod *paymentMethod = orderInfo.paymentMethods[j];
            self.paymentMethods.text = paymentMethod.name;
            self.paymentMethodId = [NSString stringWithFormat:@"%ld",paymentMethod.id];
        }
        for (int k=0; k<orderInfo.shippingMethods.count; k++) {
            NTGShippingMethod *shippingMethod = orderInfo.shippingMethods[k];
            self.shippingMethodsName.text = shippingMethod.name;
            self.shippingMethodId = [NSString stringWithFormat:@"%ld",shippingMethod.id];
        }
        self.amountPayable.text = [NSString stringWithFormat:@"￥%.2f",orderInfo.order.amountPayable];
        if (self.receiverId == nil) {
            self.consignee.text = @"收货地址：";
        } 
    };
    [NTGSendRequest getOrderInfo:self.dict success:result];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderItems.count;
}

- (NTGCartInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGCartInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.orderItem = self.orderItems[indexPath.row];
    return cell;
}

/** 收货地址 */
- (IBAction)receiverBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGReceiver" bundle:nil];
    NTGReceiverListController *receiverListController = [storyboard instantiateInitialViewController];
    //当收货地址发生改变时回调下面的BLOCK,从而self.receiver里才会有值
    receiverListController.returnTextBlock = ^(NTGReceiverContent *receiver) {
        receiver.isDefault = NO;
        self.receiver = receiver;
        self.consignee.text = receiver.consignee;
        self.phone.text = receiver.phone;
        self.address.text = [receiver.areaName stringByAppendingString:receiver.address];
    };
    
    if (self.receiver) {
        receiverListController.recs = self.receivers;
        receiverListController.receiver = self.receiver;
    }
    [self.navigationController pushViewController:receiverListController animated:YES];
}

- (IBAction)createOrder:(id)sender {
    if (self.receiverId == nil) {
        [NTGMBProgressHUD alertView:@"请填写收货地址！" view:self.view];
        return;
    }
    if (self.receiverId) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGOrderCreate" bundle:nil];
        NTGOrderCreateController *orderCreateController = [storyboard instantiateInitialViewController];
        orderCreateController.strTile = self.amountPayable.text;
        orderCreateController.cartToken = self.orderInfo.cartToken;
        orderCreateController.ids = self.ids;
        orderCreateController.receiverId = self.receiverId;
        orderCreateController.paymentMethodId = self.paymentMethodId;
        orderCreateController.shippingMethodId = self.shippingMethodId;
        [self.navigationController pushViewController:orderCreateController animated:YES];
    }
}

/** 提交订单 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"invoice"]) {
        NTGInvoiceController *invoiceController = segue.destinationViewController;
        invoiceController.returnTextBlock = ^(NSString *showText) {
            self.invoiceTitle.text = showText;
        };
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
