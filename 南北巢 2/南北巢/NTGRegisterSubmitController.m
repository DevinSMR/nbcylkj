/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRegisterSubmitController.h"
#import "NTGMBProgressHUD.h"
#import "NTGValidateMobile.h"
#import "NTGSendRequest.h"
#import "NTGMember.h"
#import "CocoaSecurity.h"

/**
 * control - 注册
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRegisterSubmitController ()
/** 手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *securityCode;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
/** 确认密码 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPass;
@property (nonatomic,copy) NSString *validCodeKey;
/** 获取验证码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *secarityBtn;

@end

@implementation NTGRegisterSubmitController

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_secarityBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
}

/** 获取验证码 */
- (void)startTime{
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
    NSDictionary *repram;
    if (self.phoneNum.text) {
        repram = @{@"mobile":self.phoneNum.text};
    }
    if (![NTGValidateMobile validateMobile:self.phoneNum.text]) {
        
        [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
    }else {
        
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            //        NSLog(@"%d",[responseObject intValue]);
            if ([responseObject intValue] == 0) {
                
                [NTGMBProgressHUD alertView:@"该手机号已注册" view:self.view];
                
            }else {
                NTGBusinessResult *results = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
                NSDictionary *dict;
                
                dispatch_resume(_timer);
                if (self.member) {
                    dict = @{@"mobile":self.member.mobile};
                }else {
                    dict = @{@"mobile":self.phoneNum.text};
                }
                
                results.onSuccess = ^(id responseObject) {
                    self.validCodeKey = responseObject;
                    [NTGMBProgressHUD alertView:@"验证码已经发送" view:self.view];
                };
                [NTGSendRequest getSMSValidCode:dict success:results];
                
            }
        };
        [NTGSendRequest registerCheck_mobile:repram success:result];
        
    }
}

/** 保存 */
- (IBAction)saveBtn:(id)sender {
    if (![self checkFinish]) {
        return;
    }
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    NSString *password = self.passwordNew.text;
    if (password.length<6 || password.length>20) {
        [NTGMBProgressHUD alertView:@"请输入6~20位密码" view:self.view];
        return;
    }
    CocoaSecurityResult * securityEnPassword = [CocoaSecurity md5:password];
    NSString * md5Hex = securityEnPassword.hexLower;

    NSDictionary *dicts = @{
                            @"mobile":self.phoneNum.text,
                            @"enPassword":md5Hex,
                            @"validCodeKey":self.validCodeKey,
                            @"validCodeValue":self.securityCode.text
                            };
    [NTGSendRequest registerSubmit:dicts success:result];
    result.onSuccess = ^(id responseObject) {
        [NTGMBProgressHUD alertView:@"注册成功！" view:self.view];
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
}

/** 检查收货人资料信息完整度 */
- (BOOL)checkFinish {
    BOOL finish = YES;
    if (
        self.phoneNum.text.length==0 ||
        self.passwordNew.text.length==0 ||
        self.validCodeKey.length==0 ||
        self.securityCode.text.length==0
        ) {
        [NTGMBProgressHUD alertView:@"亲，资料不完整哦!" view:self.view];
        return NO;
    }
    return finish;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
