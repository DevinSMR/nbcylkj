/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInstitutionOrderController.h"
#import <UIImageView+WebCache.h>
#import "NTGSendRequest.h"
#import "CalendarHomeViewController.h"
#import "NTGPersonalView.h"
#import "NTGOrderCreateController.h"
#import "NTGIsInvoiceController.h"
#import "NTGMBProgressHUD.h"
#import "NTGValidateMobile.h"

/**
 * control - 机构订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionOrderController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
/** 机构图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 机构名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 机构地址 */
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
/** 入住人信息 */
@property (weak, nonatomic) IBOutlet UITableView *personalTable;
/** 联系人 */
@property (weak, nonatomic) IBOutlet UITextField *consignee;
/** 电话 */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/** 邮箱 */
@property (weak, nonatomic) IBOutlet UITextField *email;
/** 发票信息 */
@property (weak, nonatomic) IBOutlet UILabel *invoiceInfo;
/** 入住日期 */
@property (weak, nonatomic) IBOutlet UILabel *startDate;
/** 离开日期 */
@property (weak, nonatomic) IBOutlet UILabel *endDate;
/** 床位数量 */
@property (weak, nonatomic) IBOutlet UILabel *bedCount;
/** 金额 */
@property (weak, nonatomic) IBOutlet UILabel *amount;
/** 订单金额 */
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
/** 减号 */
@property (weak, nonatomic) IBOutlet UIButton *adultMinus;
@property (nonatomic,strong) CalendarHomeViewController *chvc;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,copy) NSString *invoice_Consignee;
@property (nonatomic,copy) NSString *invoice_Address;
@property (nonatomic,copy) NSString *invoice_Detail;
@property (nonatomic,assign) BOOL isInvoice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;

@end

@implementation NTGInstitutionOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.lblName.text = self.seller.name;
    self.lblAddress.text = self.product.sellerAddress;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.product.guestRoom.roomEnvironmentImage]];
    [self departureDate];
    [self initData];
    [self changeMinusBtnState];
    self.personalTable.rowHeight = 95;
    [self.personalTable reloadData];
    self.isInvoice = NO;
    self.navigationItem.title = @"订单填写";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initData {
    if (self.startDate.text.length<=0 || self.endDate.text.length<=0 || self.bedCount.text.length<=0) {
        return;
    }
    NSDictionary *dict = @{
                           @"productId":[NSString stringWithFormat:@"%ld",self.product.id],
                           @"roomCount":self.bedCount.text,
                           @"startDate":self.startDate.text,
                           @"endDate":self.endDate.text
                           };
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSNumber *amount) {
        self.viewH.constant = ([self.bedCount.text intValue] -1)*95 + 460;
        self.price = amount;
        self.amount.text = [NSString stringWithFormat:@"￥%.2f", [amount floatValue]];
        self.lblAmount.text = [NSString stringWithFormat:@"费用：￥%.2f", [amount floatValue]];
    };
    [NTGSendRequest roomOrderCalculate:dict success:result];
}

/** 当前日期 */
- (void)departureDate {
//    NSDate * senddate=[NSDate date];
    NSDate *date = [NSDate date];
    NSDate *lastDay = [NSDate dateWithTimeInterval:0*60*60 sinceDate:date];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags= NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponentL= [cal components:unitFlags fromDate:lastDay];
    NSDateComponents * conponentN= [cal components:unitFlags fromDate:nextDat];
    NSInteger year=[conponentL year];
    NSInteger month=[conponentL month];
    NSInteger startDay=[conponentL day];
    NSInteger endMonth=[conponentN month];
    NSInteger endDay = [conponentN day];
    NSString *nsStartDateString= [NSString stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)month,(long)startDay];
    NSString * nsEndDateString= [NSString stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)endMonth,(long)endDay];
    self.startDate.text = nsStartDateString;
    self.endDate.text = nsEndDateString;
}

/** 入住时间选择 */
- (IBAction)startDateChoose:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (!self.chvc) {
        
        self.chvc = [[CalendarHomeViewController alloc]init];
        
        self.chvc.calendartitle = @"选择出发日期";
        
        [self.chvc setAirPlaneToDay:365 ToDateforString:nil];
    }
    self.chvc.calendarblock = ^(CalendarDayModel *model){
        
        if (model.holiday) {
            weakSelf.startDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initData];
        }else{
            weakSelf.startDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initData];
        }
    };
    [self.navigationController pushViewController:self.chvc animated:YES];
}

/** 离开时间选择 */
- (IBAction)endDateChoose:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (!self.chvc) {
        self.chvc = [[CalendarHomeViewController alloc]init];
        
        self.chvc.calendartitle = @"选择日期";
        
        [self.chvc setAirPlaneToDay:365 ToDateforString:nil];
    }
    self.chvc.calendarblock = ^(CalendarDayModel *model){
        
        if (model.holiday) {
            weakSelf.endDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initData];
        }else{
            weakSelf.endDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initData];
        }
    };
    
    [self.navigationController pushViewController:self.chvc animated:YES];
}

- (IBAction)changeCount:(id)sender {
    NSInteger currentBedCount = [self.bedCount.text integerValue];
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        self.bedCount.text = [NSString stringWithFormat:@"%ld",(long)--currentBedCount];
    }
    if (btn.tag == 200) {
        self.bedCount.text = [NSString stringWithFormat:@"%ld",(long)++currentBedCount];
    }
    
    [self changeMinusBtnState];
    [self initData];
    [self.personalTable reloadData];
    
}


/** 控制减号状态 */
- (void) changeMinusBtnState {
    if ([self.bedCount.text intValue] <= 1) {
        [self.adultMinus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
        [self.adultMinus setEnabled:NO];
    }else{
        [self.adultMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.adultMinus setEnabled:YES];
    }
}

#pragma 数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bedCount.text integerValue];
}

-(NTGPersonalView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGPersonalView *cell =[tableView dequeueReusableCellWithIdentifier:@"personalView"];

    return cell;
}

/** 立即支付 */
- (IBAction)createRoomOrder:(id)sender {
    if (self.startDate.text.length<=0 || self.endDate.text.length<=0 || self.bedCount.text.length<=0) {
        return;
    }
    if ([self.consignee.text isEqualToString:@""]) {
        [NTGMBProgressHUD alertView:@"请输入预定人姓名" view:self.view];
        return;
    }
    if ([self.phone.text isEqualToString:@""]) {
        [NTGMBProgressHUD alertView:@"请输入预定人电话" view:self.view];
        return;
    }
    if (![NTGValidateMobile validateMobile:self.phone.text]) {
        [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
        return;
    }
    if (![NTGValidateMobile validateEmail:self.email.text]) {
        [NTGMBProgressHUD alertView:@"请输入正确的邮箱" view:self.view];
        return;
    }
    NSInteger numberOfSections = self.personalTable.numberOfSections - 1;
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithCapacity:10];
    
    for (int i = 0 ; i<[self.bedCount.text integerValue]; i++) {
        NSIndexPath *pathOne=[NSIndexPath indexPathForRow:i inSection:numberOfSections];//获取cell的位置
        NTGPersonalView *personalViewCell = [self.personalTable cellForRowAtIndexPath:pathOne];
        NSString * name =personalViewCell.name.text;
        NSString * certificatesNumber =personalViewCell.certificatesNumber.text;
        if ([name isEqualToString:@""]) {
            [NTGMBProgressHUD alertView:@"请输入入住人姓名" view:self.view];
            return;
        }
        if (![NTGValidateMobile validateIdentityCard:certificatesNumber]) {
            [NTGMBProgressHUD alertView:@"请输入正确的身份证号码" view:self.view];
            return;
        }
        [dicts setObject:name forKey:[NSString stringWithFormat:@"tempGuests[%d].name",i]];
        [dicts setObject:certificatesNumber forKey:[NSString stringWithFormat:@"tempGuests[%d].certificatesNumber",i]];
    }
    [dicts setObject:self.consignee.text forKey:@"consignee"];
    [dicts setObject:self.bedCount.text forKey:@"roomCount"];
    [dicts setObject:self.phone.text forKey:@"phone"];
    [dicts setObject:self.startDate.text forKey:@"startDate"];
    [dicts setObject:self.endDate.text forKey:@"endDate"];
    [dicts setObject:[NSString stringWithFormat:@"%ld",self.product.id] forKey:@"productId"];
    if (self.isInvoice) {
        [dicts setObject:self.invoice_Detail forKey:@"invoice_Detail"];
        [dicts setObject:self.invoiceInfo.text forKey:@"invoice_Title"];
        [dicts setObject:[NSString stringWithFormat:@"%d",self.isInvoice] forKey:@"isInvoice"];
        [dicts setObject:self.invoice_Consignee forKey:@"invoice_Consignee"];
        [dicts setObject:self.invoice_Address forKey:@"invoice_Address"];
    }
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSNumber *orderSn) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGOrderCreate" bundle:nil];
        NTGOrderCreateController *orderCreateController = [storyboard instantiateInitialViewController];
        orderCreateController.orderSn = orderSn;
        orderCreateController.strTile = self.price.description;
        [self.navigationController pushViewController:orderCreateController animated:YES];
    };
    [NTGSendRequest createRoomOrder:dicts success:result];
}
/** 发票信息 */
- (IBAction)isInvoice:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGIsInvoice" bundle:nil];
    NTGIsInvoiceController *isInvoiceController = [storyboard instantiateInitialViewController];
    isInvoiceController.returnTextBlock = ^(NSString *invoice_Title,NSString *invoice_Consignee,NSString *invoice_Address,NSString *invoice_Detail,BOOL isInvoice) {
        self.invoice_Detail = invoice_Detail;
        self.invoiceInfo.text = invoice_Title;
        self.invoice_Consignee = invoice_Consignee;
        self.invoice_Address = invoice_Address;
        self.isInvoice = isInvoice;
    };
    [self.navigationController pushViewController:isInvoiceController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
