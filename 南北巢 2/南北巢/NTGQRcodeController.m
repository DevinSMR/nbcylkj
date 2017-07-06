/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGQRcodeController.h"
#import "NTGSendRequest.h"
#import "HMScannerController.h"
#import "NTGMember.h"

/**
 * control - 二维码
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGQRcodeController ()
/** 二维码 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation NTGQRcodeController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二维码";
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMember *member) {
        
        NSString *erweima = [NSString stringWithFormat: @"http://www.nbcyl.com/supplier/add.jhtml?id=%@",[NSString stringWithFormat:@"%ld",member.id]];
        
        [HMScannerController cardImageWithCardName:erweima avatar:nil scale:0.2 completion:^(UIImage *image){
            self.iconView.image = image;
        }];
    };
    [NTGSendRequest getProfile:nil success:result];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
