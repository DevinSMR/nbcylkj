/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderListController.h"
#import "NTGOrderCell.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGOrder.h"
#import "NTGBankCardListController.h"
#import "NTGShipping.h"
#import "NTGMyEvaluationController.h"
#import "NTGOrderProductCell.h"
#import "NTGProductDetailController.h"
#import "NTGAgencyPageController.h"
#import "NTGTravelDetailController.h"

/**
 * control - 订单列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderListController ()<UITableViewDataSource,UITableViewDelegate,NTGOrderCellDelegate>
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/** 订单列表视图 */
@property (weak, nonatomic) IBOutlet UITableView *orderTable;
/** 订单列表模型 */
@property (nonatomic,strong) NSArray *orders;
@property (nonatomic,assign) int orderItemCount;
@end

@implementation NTGOrderListController

- (void)setOrders:(NSArray *)orders {
    _orders = orders;
    [self.orderTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.param valueForKey:@"_title_"];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)initData {
    NSDictionary *dict = @{@"orderType":[self.param valueForKey:@"orderType"]};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page) {
        self.orders = page.content;
        if (page.content.count == 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.orderTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"抱歉，还没有订单！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest orderList:dict success:result];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}

- (NTGOrderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGOrderCell *cell = [NTGOrderCell cellWithTableView:tableView];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
    }
    cell.order = self.orders[indexPath.row];
    cell.delegateOrderCell = self;
    [cell setValue:[self.param valueForKey:@"orderType"] forKey:@"orderType"];
    self.orderItemCount = (int)cell.order.orderItems.count;
    [cell.cancelBtn addTarget:self action:@selector(cancelOrDelete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deliveryBtn addTarget:self action:@selector(checkDelivery:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200 + 60*(self.orderItemCount - 1);
}

/** 查看物流 */
- (void)checkDelivery:(UIButton *)btn {
    NTGOrderCell *cell = (NTGOrderCell *)btn.superview.superview;
    NSArray *shippings = cell.order.shippings;
    for (int i = 0; i<shippings.count; i++) {
        NTGShipping *shipping = shippings[i];
        if (shipping.trackingNo == nil || shipping.deliveryCorp == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"暂无物流信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"物流公司：%@\n快递单号：%@",shipping.deliveryCorp,shipping.trackingNo]  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
}

/** 付款或者评价订单 */
- (void)clickBtn:(NTGOrder *)order button:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"付款"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGBankCardList" bundle:nil];
        NTGBankCardListController *bankCardListController = [storyboard instantiateInitialViewController];
        bankCardListController.sn = order.sn;
        [self.navigationController pushViewController:bankCardListController animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"评价订单"]) {
        [self performSegueWithIdentifier:@"review" sender:btn];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NTGMyEvaluationController *myEvaluationController = segue.destinationViewController;
    UIButton *btn = (UIButton *)sender;
    NTGOrderCell *cell = (NTGOrderCell *)btn.superview.superview;
    myEvaluationController.orderSn = cell.order.sn;
}

/** 取消/删除订单 */
- (void)cancelOrDelete:(UIButton *)btn {
    NTGOrderCell *cell = (NTGOrderCell *)btn.superview.superview;
    NSDictionary *dict = @{@"sn":cell.order.sn};
    if ([btn.titleLabel.text isEqualToString:@"取消订单"]) {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            [self initData];
        };
        [NTGSendRequest orderCancel:dict success:result];
    }else if ([btn.titleLabel.text isEqualToString:@"删除订单"]) {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            [self initData];
        };
        [NTGSendRequest orderDelete:dict success:result];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
