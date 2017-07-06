/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderViewController.h"
#import "NTGSendRequest.h"
#import "NTGOrderContent.h"
#import "NTGOrderViewCell.h"

/**
 * control - 商品订单详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
/** 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *lblSn;
/** 发货状态 */
@property (weak, nonatomic) IBOutlet UILabel *shippingStatus;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *freight;
/** 订单金额 */
@property (weak, nonatomic) IBOutlet UILabel *amount;
/** 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *consignee;
/** 收货人电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 收货地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** 确认收货按纽 */
@property (weak, nonatomic) IBOutlet UIButton *confirmDeliveryBtn;
/** 查看物流按钮 */
@property (weak, nonatomic) IBOutlet UIButton *checkDeliveryBtn;
/** 订单商品列表 */
@property (weak, nonatomic) IBOutlet UITableView *orderViewTable;

@property (nonatomic,strong) NSArray *orderItems;
@property (nonatomic,strong) NSArray *shippings;
@end

@implementation NTGOrderViewController

-(void)setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self.orderViewTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self initData];
    self.height.constant = self.productCount*85;
    [self.orderViewTable setFrame:CGRectMake(0, 142, self.view.frame.size.width, self.height.constant)];
    [self.checkDeliveryBtn addTarget:self action:@selector(checkDelivery:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initData {
    NSDictionary *dict = @{@"sn":self.sn};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGOrderContent *orderContent) {
        self.orderItems = orderContent.orderItems.content;
        self.lblSn.text = orderContent.order.sn;
        self.shippings = orderContent.order.shippings;
        /** 已完成 可以查看物流*/
        if ([orderContent.order.orderStatus isEqualToString:@"completed"]) {
            self.shippingStatus.text = @"已完成";
            self.shippingStatus.textColor = [UIColor greenColor];
            self.confirmDeliveryBtn.hidden = YES;
            self.checkDeliveryBtn.hidden = NO;
        }else {
            /** 未确认或者未支付 不能查看物流和确认收货*/
            if ([orderContent.order.orderStatus isEqualToString:@"unconfirmed"]||[orderContent.order.paymentStatus isEqualToString:@"unpaid"]) {
                self.shippingStatus.text = @"未发货";
                self.shippingStatus.textColor = [UIColor orangeColor];
                self.confirmDeliveryBtn.hidden = YES;
                self.checkDeliveryBtn.hidden = YES;
            /** 取消 不能查看物流和确认收货*/
            }else if ([orderContent.order.orderStatus isEqualToString:@"cancelled"]) {
                self.shippingStatus.text = @"已取消";
                self.shippingStatus.textColor = [UIColor orangeColor];
                self.confirmDeliveryBtn.hidden = YES;
                self.checkDeliveryBtn.hidden = YES;
            }else if ([orderContent.order.paymentStatus isEqualToString:@"paid"]) {
                /** 已支付未发货 不能查看物流和确认收货*/
                if ([orderContent.order.shippingStatus isEqualToString:@"unshipped"]) {
                self.shippingStatus.text = @"未发货";
                self.shippingStatus.textColor = [UIColor orangeColor];
                    self.confirmDeliveryBtn.hidden = YES;
                    self.checkDeliveryBtn.hidden = YES;
                /** 已支付已发货 可以查看物流和确认收货*/
                }else if ([orderContent.order.shippingStatus isEqualToString:@"shipped"]) {
                    self.shippingStatus.text = @"已发货";
                    self.shippingStatus.textColor = [UIColor greenColor];
                    self.confirmDeliveryBtn.hidden = NO;
                    self.checkDeliveryBtn.hidden = NO;
                }
            }
        }
        self.freight.text = [NSString stringWithFormat:@"%.2f",orderContent.order.freight];
        self.amount.text = [NSString stringWithFormat:@"￥%.2f",[orderContent.order.amount floatValue]];
        self.consignee.text = orderContent.order.consignee;
        self.phone.text = orderContent.order.phone;
        self.address.text = [orderContent.order.areaName stringByAppendingString: orderContent.order.address];
    };
    [NTGSendRequest orderView:dict success:result];
}

#pragma 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderItems.count;
}

- (NTGOrderViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderViewCell" forIndexPath:indexPath];
    
    cell.orderItem = self.orderItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

/** 查看物流 */
- (void)checkDelivery:(UIButton *)btn {
    for (int i = 0; i<self.shippings.count; i++) {
        NTGShipping *shipping = self.shippings[i];
        if (shipping.trackingNo == nil || shipping.deliveryCorp == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"暂无物流信息" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"物流公司：%@\n快递单号：%@",shipping.deliveryCorp,shipping.trackingNo]  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
