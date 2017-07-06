/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMineController.h"
#import "NTGLoginController.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticleCategory.h"
#import "NTGMember.h"
#import "CocoaSecurity.h"

/**
 * control - 
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMineController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *erweima;
@property (weak, nonatomic) IBOutlet UITableViewCell *fenxiaoshang;
@end

@implementation NTGMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.erweima.hidden = YES;
    self.fenxiaoshang.hidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //            登陆成功后把用户名和密码存储到UserDefault
    CocoaSecurityResult * securityEnPassword = [CocoaSecurity md5:[userDefaults valueForKey:@"password"]];
    NSString * md5Hex = securityEnPassword.hexLower;
    if ([userDefaults valueForKey:@"name"] == nil || md5Hex == nil) {
        return;
    }
    NSDictionary * dict = @{@"username":[userDefaults valueForKey:@"name"], @"enPassword":md5Hex};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMember * member) {
        if ([member.platformType isEqualToString:@"supplier"]) {
            self.erweima.hidden = NO;
            self.fenxiaoshang.hidden = NO;
        }else {
            self.erweima.hidden = YES;
            self.fenxiaoshang.hidden = YES;
        }
    };
    [NTGSendRequest login:dict success:result];
    
   
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;

}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 6)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 6)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
