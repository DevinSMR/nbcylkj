/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTravelOrderController.h"
#import "NTGTravelerCell.h"
#import "NTGMBProgressHUD.h"
#import "NTGIsInvoiceController.h"
#import "NTGSendRequest.h"
#import "NTGOrderCreateController.h"
#import "NTGValidateMobile.h"

/**
 * control - 旅游订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelOrderController ()<UITableViewDataSource,UITableViewDelegate>
/** 出发日期 */
@property (weak, nonatomic) IBOutlet UILabel *startDate;
/** 成人数量 */
@property (weak, nonatomic) IBOutlet UILabel *adultCount;
/** 儿童数量 */
@property (weak, nonatomic) IBOutlet UILabel *childCount;
/** 费用 */
@property (weak, nonatomic) IBOutlet UILabel *amount;
/** 联系人 */
@property (weak, nonatomic) IBOutlet UITextField *consignee;
/** 手机号码 */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/** 邮箱 */
@property (weak, nonatomic) IBOutlet UITextField *email;
/** 发票信息 */
@property (weak, nonatomic) IBOutlet UILabel *invoiceInfo;
/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
/** 旅客信息列表 */
@property (weak, nonatomic) IBOutlet UITableView *travelerTable;
/** scrollview的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
@property (nonatomic,copy) NSString *invoice_Consignee;
@property (nonatomic,copy) NSString *invoice_Address;
@property (nonatomic,copy) NSString *invoice_Detail;
@property (nonatomic,assign) BOOL isInvoice;
@property (nonatomic,assign) BOOL isAdult;
@end

#define NTGTravelerCellHeight 160.0f
#define NTGHeight 390.0f

@implementation NTGTravelOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"立即预定";
    self.startDate.text = self.sstartDate;
    self.adultCount.text = self.sadultCount;
    self.childCount.text = self.schildCount;
    NSString *amountStr = @"费用：";
    self.amount.text = [amountStr stringByAppendingString:self.samount];
    self.lblAmount.text = self.amount.text;
    self.travelerTable.dataSource = self;
    self.travelerTable.delegate = self;
    self.travelerTable.rowHeight = 160;
    self.viewH.constant = NTGTravelerCellHeight * ([self.sadultCount integerValue] + [self.schildCount integerValue]) + NTGHeight;
    self.isAdult = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 0 ;
    if ([self.childCount.text intValue]>0) {
        section = 2;
    }else if ([self.childCount.text intValue] == 0) {
        section = 1;
    }
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (section == 0) {
        count = [self.sadultCount integerValue];
    }
    if (section == 1) {
        count = [self.schildCount integerValue];
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGTravelerCell *travelerCell =[tableView dequeueReusableCellWithIdentifier:@"travelerCell"];
    return travelerCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 23)];
    UILabel *lblTraveler = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 100, 19)];
    lblTraveler.font = [UIFont systemFontOfSize:14];
    [headView addSubview:lblTraveler];
    if (section == 0) {
        lblTraveler.text = @"成人";
    }
    if (section == 1) {
        lblTraveler.text = @"儿童";
    }
    return headView;
}

/** 发票信息 */
- (IBAction)invoiceInfoBtn:(id)sender {
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

/** 提交订单 */
- (IBAction)createOrder:(id)sender {
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
    if ([self.email.text isEqualToString:@""]) {
        [NTGMBProgressHUD alertView:@"请输入预定人邮箱" view:self.view];
        return;
    }
    if (![NTGValidateMobile validateEmail:self.email.text]) {
        [NTGMBProgressHUD alertView:@"请输入正确的邮箱" view:self.view];
        return;
    }
    NSInteger numberOfSections = self.travelerTable.numberOfSections;
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithCapacity:10];
    int i = 0;
    for ( ; i<[self.sadultCount integerValue]; i++) {
        NSIndexPath *pathOne=[NSIndexPath indexPathForRow:i inSection:numberOfSections-2];//获取cell的位置
        NTGTravelerCell *travelerCell = [self.travelerTable cellForRowAtIndexPath:pathOne];
        NSString * name =travelerCell.name.text;
        NSString * certificatesNumber =travelerCell.certificatesNumber.text;
        NSString *phone = travelerCell.phone.text;
        [dicts setObject:name forKey:[NSString stringWithFormat:@"tempGuests[%d].name",i]];
        [dicts setObject:certificatesNumber forKey:[NSString stringWithFormat:@"tempGuests[%d].certificatesNumber",i]];
        [dicts setObject:phone forKey:[NSString stringWithFormat:@"tempGuests[%d].phone",i]];
        [dicts setObject:[NSString stringWithFormat:@"%d",self.isAdult] forKey:[NSString stringWithFormat:@"tempGuests[%d].isAdult",i]];
    }
    if ([self.childCount.text intValue] > 0) {
        self.isAdult = NO;
        for (int j = i ; j<[self.schildCount integerValue]+[self.sadultCount integerValue]; j++) {
            for (int k=0; k<[self.schildCount integerValue]; k++) {
                
                NSIndexPath *pathOne=[NSIndexPath indexPathForRow:k inSection:numberOfSections-1];//获取cell的位置
                NTGTravelerCell *travelerCell = [self.travelerTable cellForRowAtIndexPath:pathOne];
                NSString * name =travelerCell.name.text;
                if ([name isEqualToString:@""]) {
                    [NTGMBProgressHUD alertView:@"请输入入住人姓名" view:self.view];
                    return;
                }
                NSString * certificatesNumber =travelerCell.certificatesNumber.text;
                if (![NTGValidateMobile validateIdentityCard:certificatesNumber]) {
                    [NTGMBProgressHUD alertView:@"请输入正确的身份证号码" view:self.view];
                    return;
                }
                NSString *phone = travelerCell.phone.text;
                if (![NTGValidateMobile validateMobile:phone]) {
                    [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
                    return;
                }
                [dicts setObject:name forKey:[NSString stringWithFormat:@"tempGuests[%d].name",j]];
                [dicts setObject:certificatesNumber forKey:[NSString stringWithFormat:@"tempGuests[%d].certificatesNumber",j]];
                [dicts setObject:phone forKey:[NSString stringWithFormat:@"tempGuests[%d].phone",j]];
                [dicts setObject:[NSString stringWithFormat:@"%d",self.isAdult] forKey:[NSString stringWithFormat:@"tempGuests[%d].isAdult",j]];
            }
        }
    }
    [dicts setObject:self.consignee.text forKey:@"consignee"];
    [dicts setObject:self.phone.text forKey:@"phone"];
    [dicts setObject:self.email.text forKey:@"email"];
    [dicts setObject:self.startDate.text forKey:@"startDate"];
    [dicts setObject:[NSString stringWithFormat:@"%ld",self.trip.product.id] forKey:@"productId"];
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
        orderCreateController.strTile = self.samount;
        [self.navigationController pushViewController:orderCreateController animated:YES];
    };
    [NTGSendRequest createTripOrder:dicts success:result];
}

@end
