/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGVerificationController.h"
#import "NTGMember.h"
#import "NTGSendRequest.h"
#import "NTGMBProgressHUD.h"
#import "NTGValidateMobile.h"

/**
 * control - 手机验证
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGVerificationController ()
/** 手机号 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *verification;
/** 新手机号 */
@property (weak, nonatomic) IBOutlet UITextField *upPhoneNum;
/** 获取验证码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *secarityBtn;

@property (nonatomic,copy) NSString *validCodeKey;
@end

@implementation NTGVerificationController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机验证";
    NSString *tel = [self.member.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.phoneNum.text = tel;
    [_secarityBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

/** 获取验证码 */
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_secarityBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                _secarityBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            if (seconds == 0) {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_secarityBtn setTitle:[NSString stringWithFormat:@"获取验证码(%@秒)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _secarityBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    NSDictionary *dict = nil;
    if (!self.member.mobile) {
        self.member.mobile = @"";
    }
    dict = @{@"mobile":self.member.mobile};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        self.validCodeKey = responseObject;
    };
    [NTGSendRequest getSMSValidCode:dict success:result];
}

/** 保存 */
- (IBAction)saveBtn:(id)sender {
    if ([self.verification.text integerValue] == 0) {
        [NTGMBProgressHUD alertView:@"请填写验证码" view:self.view];
        return;
    }
    if (self.upPhoneNum.text.length == 0) {
        [NTGMBProgressHUD alertView:@"请填写新手机号" view:self.view];
        return;
    }
    if (![NTGValidateMobile validateMobile:self.upPhoneNum.text]) {
        
        [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
        return;
    }
    NSDictionary *dicts;
    if (self.validCodeKey) {
        
        dicts = @{
                  @"mobile":self.upPhoneNum.text,
                  @"validCodeKey":self.validCodeKey,
                  @"validCodeValue":self.verification.text
                  };
    }
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest getUpdateMobile:dicts success:result];
}

///** 检验手机号码正确性 */
//- (BOOL)isMobileNumber:(NSString *)mobileNum {
// 
//    NSString * MOBILE = @"^1(3[0-9]5[0-35-9]8[025-9]8[0-9]77)\\d{8}$";
//    NSString * CM = @"^1(34[0-8](3[5-9]5[017-9]8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]5[256]8[56])\\d{8}$";
//    NSString * CT = @"^1(349(33538[09]77)\\d)\\d{7}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)||
//        
//        ([regextestcm evaluateWithObject:mobileNum] == YES)||
//        
//        ([regextestcu evaluateWithObject:mobileNum] == YES)||
//        
//        [regextestct evaluateWithObject:mobileNum] == YES)
//    {
//        return YES;
//        
//    }else {
//        [NTGMBProgressHUD alertView:@"请输入正确的手机号码!" view:self.view];
//        return NO;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
