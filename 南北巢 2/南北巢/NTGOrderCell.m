/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderCell.h"
#import "NTGOrder.h"
#import "NTGOrderProductCell.h"
#import "NTGBavBaseController.h"
#import "NTGOrderViewController.h"
#import "NTGProductDetailController.h"
#import "NTGAgencyPageController.h"
#import "NTGTravelDetailController.h"
#import "NTGInstitutionOrderViewController.h"

/**
 * view - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGOrderCell ()<UITableViewDataSource,UITableViewDelegate,NTGOrderProductDelegate>
/** 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *lblSn;
/** 订单状态 */
@property (weak, nonatomic) IBOutlet UILabel *orderStaus;
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *ceateDate;
/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *amount;
/** 总数量 */
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (nonatomic,strong) NSArray *orderItems;
/** 订单商品列表 */
@property (weak, nonatomic) IBOutlet UITableView *productTable;
@end

@implementation NTGOrderCell

- (void)setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self.productTable reloadData];
}

- (void)setOrder:(NTGOrder *)order {
    _order = order;
    self.orderItems = order.orderItems;
    self.lblSn.text = order.sn;
    if ([order.orderStatus isEqualToString:@"completed"]) {
        self.orderStaus.text = @"已完成";
        self.cancelBtn.hidden = YES;
        self.deliveryBtn.hidden = NO;
        self.reviewBtn.hidden = NO;
        self.orderStaus.textColor = [UIColor blackColor];
        [self.reviewBtn setTitle:@"评价订单" forState:UIControlStateNormal];
    
    }else {
        if ([order.orderStatus isEqualToString:@"unconfirmed"]) {
            self.orderStaus.text = @"等待付款";
            self.orderStaus.textColor = [UIColor greenColor];
            self.deliveryBtn.hidden = YES;
            self.cancelBtn.hidden = NO;
            self.reviewBtn.hidden = NO;
            [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.reviewBtn setTitle:@"付款" forState:UIControlStateNormal];
        }else if ([order.orderStatus isEqualToString:@"cancelled"]) {
            self.orderStaus.text = @"已取消";
            self.deliveryBtn.hidden = YES;
            self.cancelBtn.hidden = NO;
            self.orderStaus.textColor = [UIColor greenColor];
            [self.cancelBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            self.reviewBtn.hidden = YES;
        }else if ([order.orderStatus isEqualToString:@"confirmed"]&&[order.paymentStatus isEqualToString:@"unpaid"]) {
            self.orderStaus.text = @"等待付款";
            self.deliveryBtn.hidden = YES;
            self.cancelBtn.hidden = YES;
            self.reviewBtn.hidden = NO;
            [self.reviewBtn setTitle:@"付款" forState:UIControlStateNormal];
        }else if ([order.orderStatus isEqualToString:@"confirmed"]&&[order.paymentStatus isEqualToString:@"paid"]) {
            self.orderStaus.text = @"付款成功";
            self.deliveryBtn.hidden = YES;
            self.orderStaus.textColor = [UIColor greenColor];
            self.cancelBtn.hidden = YES;
            self.reviewBtn.hidden = YES;
        }
    }
    NSString*time = order.createDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    self.ceateDate.text = confromTimespStr;
    self.amount.text = [NSString stringWithFormat:@"￥%.2f",[order.amount floatValue]];
    self.quantity.text = [NSString stringWithFormat:@"共%d件商品",[order.quantity intValue]];
}

- (void)awakeFromNib {
    
    // Initialization code
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"orderCell";
    NTGOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGOrderCell" owner:nil options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (IBAction)paymentOrReview:(id)sender {
    if ([_delegateOrderCell respondsToSelector:@selector(clickBtn:button:)]) {
        [_delegateOrderCell clickBtn:self.order button:sender];
    }
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderItems.count;
}

- (NTGOrderProductCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGOrderProductCell *cell = [NTGOrderProductCell cellWithTableView:tableView];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderProductCell" forIndexPath:indexPath];
    }
    cell.orderItem = self.orderItems[indexPath.row];
    cell.delegateOrderPro = self;
    return cell;
}


/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NTGOrderProductCell *cell = (NTGOrderProductCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    if ([cell.delegateOrderPro respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [cell.delegateOrderPro clickindexPathRow:_orderItems[indexPath.row] index:(int)indexPath.row];
    }
}

/** 代理方法 */
-(void)clickindexPathRow:(NTGOrderItem *)orderItem index:(int)inde {
    if ([self.orderType isEqualToString:@"productOrder"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductDetail" bundle:nil];
        NTGProductDetailController *productDetailController = [storyboard instantiateInitialViewController];
        UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        productDetailController.product = orderItem.product;
        NSArray *childControllers = [tabbarController childViewControllers];
        NTGBavBaseController *hm = childControllers[4];
        [hm pushViewController:productDetailController animated:YES];
    }
    if ([self.orderType isEqualToString:@"guestRoomOrder"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgencyPage" bundle:nil];
        NTGAgencyPageController *agencyPageController = [storyboard instantiateViewControllerWithIdentifier:@"agencyPageController"];
        UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        agencyPageController.appPath = orderItem.product.wrapPath;
        NSArray *childControllers = [tabbarController childViewControllers];
        NTGBavBaseController *hm = childControllers[4];
        [hm pushViewController:agencyPageController animated:YES];
    }
    if ([self.orderType isEqualToString:@"travelOrder"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGTravelDetail" bundle:nil];
        NTGTravelDetailController *travelDetailController = [storyboard instantiateInitialViewController];
        UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        travelDetailController.appPath = orderItem.product.wrapPath;
        NSArray *childControllers = [tabbarController childViewControllers];
        NTGBavBaseController *hm = childControllers[4];
        [hm pushViewController:travelDetailController animated:YES];
    }
}

/** 订单详情 */
- (IBAction)orderViewBtn:(id)sender {
    if ([self.orderType isEqualToString:@"productOrder"]) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGOrderView" bundle:nil];
    NTGOrderViewController *orderViewController = [storyboard instantiateInitialViewController];
    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    orderViewController.sn = self.order.sn;
    NSArray *childControllers = [tabbarController childViewControllers];
    NTGBavBaseController *hm = childControllers[4];
    orderViewController.productCount = (int)self.orderItems.count;
    [hm pushViewController:orderViewController animated:YES];
    }
    if ([self.orderType isEqualToString:@"guestRoomOrder"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGInstitutionOrderView" bundle:nil];
        NTGInstitutionOrderViewController *institutionOrderViewController = [storyboard instantiateInitialViewController];
        UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        institutionOrderViewController.sn = self.order.sn;
        NSArray *childControllers = [tabbarController childViewControllers];
        NTGBavBaseController *hm = childControllers[4];
        institutionOrderViewController.orderType = @"guestRoomOrder";
        [hm pushViewController:institutionOrderViewController animated:YES];
    }
    if ([self.orderType isEqualToString:@"travelOrder"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGInstitutionOrderView" bundle:nil];
        NTGInstitutionOrderViewController *institutionOrderViewController = [storyboard instantiateInitialViewController];
        UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        institutionOrderViewController.sn = self.order.sn;
        NSArray *childControllers = [tabbarController childViewControllers];
        NTGBavBaseController *hm = childControllers[4];
        institutionOrderViewController.orderType = @"travelOrder";
        [hm pushViewController:institutionOrderViewController animated:YES];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
