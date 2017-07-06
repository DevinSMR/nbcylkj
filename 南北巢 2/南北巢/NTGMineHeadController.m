/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMineHeadController.h"
#import <UIImageView+WebCache.h>
#import "NTGSendRequest.h"
#import "NTGMember.h"
#import "NTGMyProfileController.h"
#import "NTGStringUtils.h"

/**
 * control - 头部容器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMineHeadController ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconHeadView;
/** 登陆、注册 */
@property (weak, nonatomic) IBOutlet UILabel *login;

/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *petname;
@end

@implementation NTGMineHeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithRed:248/255.0 green:111/255.0 blue:78/255.0 alpha:1];
    
    [self.view addSubview:statusBarView];
    self.iconHeadView.layer.masksToBounds = YES;
    self.iconHeadView.layer.cornerRadius = 28.5;
   // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //登陆成功后把用户名和密码存储到UserDefault
//    [userDefaults setObject:username forKey:@"name"];
//    [userDefaults setObject:password forKey:@"password"];
//    [userDefaults synchronize];
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userPhoto = [userDefaults valueForKey:@"user_photo_"];
    NSString *petName = [userDefaults objectForKey:@"petName"];
    NSString *isLogin = [userDefaults objectForKey:@"isLogin"];
    
    if ([isLogin isEqualToString:@"0"]) {
        self.login.text = @"登录/注册";
        self.login.textColor = [UIColor lightGrayColor];
        self.iconHeadView.image = [UIImage imageNamed:@"default_pictures"];
        self.petname.text = @"";

    }else{
        userPhoto = [NTGStringUtils addHttpPrefix:userPhoto];
        if (userPhoto) {
            self.login.text = @"";
        }
        [[SDImageCache sharedImageCache] removeImageForKey:userPhoto];
        [self.iconHeadView sd_setImageWithURL:[NSURL URLWithString:userPhoto]];
        self.petname.text = petName;
        
    }
    
   
}

/** 跳转我的资料 */
- (IBAction)myProfile:(id)sender {
   
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(initdata) object:[NSNumber numberWithBool:YES]];
    [self performSelector:@selector(initdata) withObject:[NSNumber numberWithBool:YES] afterDelay:0.5];
}

- (void)initdata {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMember *member) {
        self.member = member;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGMyProfile" bundle:nil];
        NTGMyProfileController *profileController = [storyboard instantiateInitialViewController];
        self.petname.text = member.petName;
        
        [[SDImageCache sharedImageCache] removeImageForKey:[NTGStringUtils addHttpPrefix:member.picture]];
        self.iconHeadView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NTGStringUtils addHttpPrefix:member.picture]]]];
        self.login.text = @"";
        [self.navigationController pushViewController:profileController animated:YES];
        
    };
    [NTGSendRequest getProfile:nil success:result];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
