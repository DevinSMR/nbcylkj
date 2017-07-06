/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGLoginController.h"
#import "NTGMBProgressHUD.h"
#import "NTGNetworkTool.h"
#import "NTGSendRequest.h"
#import <Base64.h>
#import "CocoaSecurity.h"
#import "RSA.h"
#import "NTGMember.h"
#import "NTGLoginPasswordController.h"
#import "NTGRegisterSubmitController.h"

/**
 * control - 登陆控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGLoginController ()<UITextFieldDelegate>

@end

@implementation NTGLoginController

/** 退出控制器 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.txtuserName becomeFirstResponder];
    /**注册监听*/
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.txtuserName];
    [center addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.txtpassword];
}

/** 监听文本框文字改变 */
- (void)textChanged {
    self.login.enabled = (self.txtuserName.text.length > 0 && self.txtpassword.text.length > 0);
}

/** 移除通知 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (NSData *)base64_decode : (NSString *)str{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

/** 注册 */
- (IBAction)submit:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGLoginPassword" bundle:nil];
    NTGLoginPasswordController *loginPasswordController = [storyboard instantiateInitialViewController];
    if (btn.tag == 100) {
        loginPasswordController.forgetPassword = @"忘记密码";
    }
   
    [self.navigationController pushViewController:loginPasswordController animated:YES];
}

/** 登陆方法 */
- (IBAction)clickLog:(UIButton *)sender {
    [self.view endEditing:YES];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%d",0] forKey:@"isLogin"];
    [userDefaults synchronize];
    [NTGSendRequest getPublicKey:nil success:^(id responseObject) {
        NSString *username = self.txtuserName.text;
        NSString *password = self.txtpassword.text;
        CocoaSecurityResult * securityEnPassword = [CocoaSecurity md5:password];
        NSString * md5Hex = securityEnPassword.hexLower;
        NSDictionary * dict = @{@"username":username, @"enPassword":md5Hex};
       
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(NTGMember * member) {
//            self.member = member;
            //            登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:member.userid forKey:@"ID"];
            [userDefaults setObject:username forKey:@"name"];
            [userDefaults setObject:password forKey:@"password"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",1] forKey:@"isLogin"];
            [userDefaults setObject:member.pictureOrg forKey:@"icon"];
            [userDefaults setObject:member.petName forKey:@"petName"];
            [userDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        };
        result.onFail = ^(id responseObject){
            [NTGMBProgressHUD alertView:@"对不起，您的用户名或密码错误！" view:self.view];
        };
        [NTGSendRequest login:dict success:result];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
@end
