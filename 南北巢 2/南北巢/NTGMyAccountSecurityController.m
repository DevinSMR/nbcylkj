/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGMyAccountSecurityController.h"
#import "NTGSendRequest.h"
#import "NTGMember.h"
#import "NTGVerificationController.h"
#import "NTGLoginPasswordController.h"

/**
 * control - 账户与安全
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMyAccountSecurityController ()
/** 账户名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 用户手机号 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (nonatomic,strong) NTGMember *member;
@end

@implementation NTGMyAccountSecurityController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户与安全";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initData];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 请求数据 */
- (void)initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMember *member) {
        self.name.text = member.petName;
        NSString *tel = [member.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.phone.text = tel;
        self.member = member;
    };
    [NTGSendRequest getProfile:nil success:result];
}

/** 登陆密码 */
- (IBAction)loginPassword:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGLoginPassword" bundle:nil];
    NTGLoginPasswordController *loginPasswordController = [storyboard instantiateInitialViewController];
    loginPasswordController.member = self.member;
    [self.navigationController pushViewController:loginPasswordController animated:YES];
}

/** 手机验证 */
- (IBAction)versionBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGVerification" bundle:nil];
    NTGVerificationController *verificationController = [storyboard instantiateInitialViewController];
    verificationController.member = self.member;
    [self.navigationController pushViewController:verificationController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
