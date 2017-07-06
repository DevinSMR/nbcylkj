/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInstitutionOrderViewController.h"
#import "NTGinstitutionOrderViewCell.h"
#import "NTGSendRequest.h"
#import "NTGOrderContent.h"
#import "NTGOrderViewCell.h"
#import "NTGTravelOrderViewCell.h"

/**
 * control - 机构订单详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *orderSn;
/** 订单状态 */
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *amount;
/** 联系人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *consignee;
/** 联系人电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 是否开具发票 */
@property (weak, nonatomic) IBOutlet UILabel *isInvoice;
/** 入住时间 */
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
/** 机构客房列表 */
@property (weak, nonatomic) IBOutlet UITableView *institutionTable;
/** 入住人信息列表 */
@property (weak, nonatomic) IBOutlet UITableView *guestTable;
/** 床位数 */
@property (weak, nonatomic) IBOutlet UILabel *bedCount;
@property (nonatomic,strong) NSArray *orderItems;
@property (nonatomic,strong) NSArray *guests;
@end

@implementation NTGInstitutionOrderViewController

-(void)setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self.institutionTable reloadData];
}

- (void)setGuests:(NSArray *)guests {
    _guests = guests;
    [self.guestTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self initData];
}

-(void)initData {
    NSDictionary *dict = @{@"sn":self.sn};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGOrderContent *orderContent) {
        self.orderItems = orderContent.orderItems.content;
        self.guests = orderContent.order.guests;
        
        self.orderSn.text = orderContent.order.sn;
        /** 已完成 */
        if ([orderContent.order.orderStatus isEqualToString:@"completed"]) {
            self.orderStatus.text = @"已完成";
            self.orderStatus.textColor = [UIColor greenColor];
        }else {
            /** 未确认或者未支付 */
            if ([orderContent.order.orderStatus isEqualToString:@"unconfirmed"]||[orderContent.order.paymentStatus isEqualToString:@"unpaid"]) {
                self.orderStatus.text = @"未付款";
                self.orderStatus.textColor = [UIColor greenColor];
                /** 取消 */
            }else if ([orderContent.order.orderStatus isEqualToString:@"cancelled"]) {
                self.orderStatus.text = @"已取消";
                self.orderStatus.textColor = [UIColor orangeColor];
            }else if ([orderContent.order.paymentStatus isEqualToString:@"paid"]) {
                self.orderStatus.text = @"已付款";
                self.orderStatus.textColor = [UIColor orangeColor];
            }
        }
        self.amount.text = [NSString stringWithFormat:@"￥%.2f",[orderContent.order.amount floatValue]];
        self.consignee.text = orderContent.order.consignee;
        self.phone.text = orderContent.order.phone;
        if (orderContent.order.isInvoice) {
            self.isInvoice.text = @"需要发票";
        }else {
            self.isInvoice.text = @"不需要发票";
        }
        NSString*startTime = orderContent.order.startDate;
        NSString*endTime = orderContent.order.endDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        long long start =[startTime longLongValue];
        long long end =[endTime longLongValue];
        NSDate *startDate = [[NSDate alloc]initWithTimeIntervalSince1970:start/1000.0];
        NSDate *endDate = [[NSDate alloc]initWithTimeIntervalSince1970:end/1000.0];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*startTimespStr = [formatter stringFromDate:startDate];
        NSString*endTimespStr = [formatter stringFromDate:endDate];
        NSString *startD = [startTimespStr stringByAppendingString:@"至"];
        NSString *endD = endTimespStr;
        self.lblDate.text = [startD stringByAppendingString:endD];
        self.bedCount.text = orderContent.order.quantity;
    };
    [NTGSendRequest orderView:dict success:result];
}

#pragma 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.guestTable]) {
        return self.guests.count;
    }
    if ([tableView isEqual:self.institutionTable]) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.guestTable]) {
        if ([self.orderType isEqualToString:@"guestRoomOrder"]) {
            NTGinstitutionOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"institutionOrderViewCell" forIndexPath:indexPath];
            cell.guest = self.guests[indexPath.row];
            self.guestTable.rowHeight = 50;
            return cell;
        }
        if ([self.orderType isEqualToString:@"travelOrder"]) {
            NTGTravelOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelOrderViewCell" forIndexPath:indexPath];
            cell.guest = self.guests[indexPath.row];
            self.guestTable.rowHeight = 75;
            return cell;
        }
    }
    if ([tableView isEqual:self.institutionTable]) {
        NTGOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderViewCell" forIndexPath:indexPath];
        cell.orderItem = self.orderItems[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
