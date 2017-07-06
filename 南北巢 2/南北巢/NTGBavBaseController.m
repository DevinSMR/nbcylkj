/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGBavBaseController.h"
#import "NTGHomeViewController.h"
#import "NTGClassificationController.h"
#import "NTGDiscoveryController.h"
#import "NTGShoppingCartController.h"
#import "NTGMineController.h"

/**
 * control - 主导航控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGBavBaseController ()

@end

@implementation NTGBavBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:111.0/255.0 blue:77.0/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 弹出控制器时隐藏底部 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    //首页显示TABBAR，其他页面均隐藏
    if ([viewController isKindOfClass:[NTGHomeViewController class]]
        ||[viewController isKindOfClass:[NTGClassificationController class]]
        ||[viewController isKindOfClass:[NTGDiscoveryController class]]
        ||[viewController isKindOfClass:[NTGShoppingCartController class]]
        ||[viewController isKindOfClass:[NTGMineController class]])
    {
        if (!viewController.hidesBottomBarWhenPushed) {
            viewController.hidesBottomBarWhenPushed = NO;
        }
    }
    else
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
