/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGUpdateMemberController.h"
#import "NTGMember.h"
#import "NTGSendRequest.h"
#import "NTGValidateMobile.h"
#import "NTGMBProgressHUD.h"
#import "NSString+Emoji.h"

/**
 * control - 更新用户资料
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGUpdateMemberController ()
/** 更改内容 */
@property (weak, nonatomic) IBOutlet UITextField *changeText;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation NTGUpdateMemberController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.changeText becomeFirstResponder];
    self.changeText.text = [_repram valueForKey:@"text"];
    self.navigationItem.title = [_repram valueForKey:@"_updateMember_"];
}

/** 保存 */
- (IBAction)saveBtn:(id)sender {
    NSDictionary *dict = nil;
    if ([[_repram valueForKey:@"_updateMember_"]isEqualToString:@"我的资料"]) {
        dict = @{
                 @"id":[NSString stringWithFormat:@"%ld",self.member.id],
                 @"petName":self.changeText.text,
                 };
    }else if ([[_repram valueForKey:@"_updateMember_"]isEqualToString:@"真实姓名"]) {
        dict = @{
                 @"id":[NSString stringWithFormat:@"%ld",self.member.id],
                 @"name":self.changeText.text,
                 };
    }else if ([[_repram valueForKey:@"_updateMember_"]isEqualToString:@"邮箱"]) {
        if (![NTGValidateMobile validateEmail:self.changeText.text]) {
            [NTGMBProgressHUD alertView:@"请输入正确的邮箱" view:self.view];
            return;
        }
        dict = @{
                 @"id":[NSString stringWithFormat:@"%ld",self.member.id],
                 @"email":self.changeText.text,
                 };
        
    }
    if([NSString isContainsEmoji:self.changeText.text]) {
        [NTGMBProgressHUD alertView:@"请输入不带表情的文字、字母或数字" view:self.view];
        return ;
    }
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest getUpdateMember:dict success:result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
