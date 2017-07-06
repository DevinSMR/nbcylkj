/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInsuranceDetailController.h"
#import <UIImageView+WebCache.h>
#import "NTGInsuranceContainer.h"
#import "NTGProductIntroductionController.h"
#import "NTGSendRequest.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 养老保险详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInsuranceDetailController ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic,strong) NTGInsuranceContent *insurance;
@end

@implementation NTGInsuranceDetailController

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initData {
    NSString *url = [NSString stringWithFormat:@"/app/insurance/content/%ld.jhtml",self.insuranceId];
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGInsuranceContainer *insuranceContainer) {
        self.insurance = insuranceContainer.insurance;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:insuranceContainer.insurance.product.image] placeholderImage:[UIImage imageNamed:@"icon72"]];
        self.lblName.text = insuranceContainer.insurance.product.fullName;
        self.lblPrice.text = [NSString stringWithFormat:@"%.2f",[insuranceContainer.insurance.product.price floatValue]];
        
         self.price.text = [@"￥" stringByAppendingString:[NSString  stringWithFormat:@"%.2f",[insuranceContainer.insurance.product.price floatValue]]];
    };
    [NTGSendRequest insuranceContent:nil requestAddr:url success:result];
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductIntroduction" bundle:nil];
    NTGProductIntroductionController *productIntroduction = [storyboard instantiateInitialViewController];
    
    if (btn.tag == 100) {
        productIntroduction.intro = self.insurance.noticeIntroduction;
    }else if (btn.tag == 200) {
        productIntroduction.intro = self.insurance.productIntroduction;
    }else if (btn.tag == 300) {
        productIntroduction.intro = self.insurance.clauseIntroduction;
    }else if (btn.tag == 400) {
        productIntroduction.intro = self.insurance.requireIntroduction;
    }
    [self.navigationController pushViewController:productIntroduction animated:YES];
}

- (IBAction)createBtn:(id)sender {
    [NTGMBProgressHUD alertView:@"暂时无法预订，敬请谅解！" view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
