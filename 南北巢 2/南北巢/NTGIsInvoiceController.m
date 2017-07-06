/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGIsInvoiceController.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 是否需要发票
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGIsInvoiceController ()<UIAlertViewDelegate>
/** 发票抬头 */
@property (weak, nonatomic) IBOutlet UITextField *invoice_Title;
/** 发票收货人 */
@property (weak, nonatomic) IBOutlet UITextField *invoice_Consignee;
/** 发票收货地址 */
@property (weak, nonatomic) IBOutlet UITextField *invoice_Address;
/** 发票明细 */
@property (weak, nonatomic) IBOutlet UILabel *invoice_Detail;
/** 不需要发票 */
@property (weak, nonatomic) IBOutlet UIButton *unRequireInvoice;
/** 需要发票 */
@property (weak, nonatomic) IBOutlet UIButton *requireInvoice;
@property (nonatomic,copy) NSString *invoiceDetail;
@end

@implementation NTGIsInvoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.unRequireInvoice.selected = YES;
    self.requireInvoice.selected = NO;
    self.navigationItem.title = @"发票信息";
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/** 保存 */
- (IBAction)saveBtn:(id)sender {
    if (self.requireInvoice.selected) {
        if ([self.invoice_Title.text isEqualToString:@""]) {
            [NTGMBProgressHUD alertView:@"请填写发票抬头" view:self.view];
            return;
        }
        if ([self.invoice_Consignee.text isEqualToString:@""]) {
            [NTGMBProgressHUD alertView:@"请填写收件人" view:self.view];
            return;
        }
        if ([self.invoice_Address.text isEqualToString:@""]) {
            [NTGMBProgressHUD alertView:@"请填写街道地址" view:self.view];
            return;
        }
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.invoice_Title.text,self.invoice_Consignee.text,self.invoice_Address.text,self.invoiceDetail,self.requireInvoice.selected);
        }
    }
    if (self.unRequireInvoice.selected) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(@"不需要发票",nil,nil,nil,NO);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/** 不需要发票 */
- (IBAction)unInvoice:(id)sender {
    self.unRequireInvoice.selected = YES;
    self.requireInvoice.selected = NO;
}

/** 需要发票 */
- (IBAction)invoice:(id)sender {
    self.requireInvoice.selected = YES;
    self.unRequireInvoice.selected = NO;
}

/** 发票明细 */
- (IBAction)invoiceDetail:(id)sender {
    UIAlertView *invoiceDetail = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"养老机构产生费",@"老年用品产生费",@"旅游产生费",nil];
    [invoiceDetail show];
}

/** 选择发票明细 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        self.invoice_Detail.text = @"养老机构产生费";
        self.invoiceDetail = @"elderlyInstitutionFee";
    }
    if (buttonIndex == 1) {
        self.invoice_Detail.text = @"老年用品产生费";
        self.invoiceDetail = @"elderlyProductFee";
    }
    if (buttonIndex == 2) {
        self.invoice_Detail.text = @"旅游产生费";
        self.invoiceDetail = @"elderlyTravelFee";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
