//
//  NBCMainController.m
//  南北巢
//
//  Created by test on 15/10/15.
//  Copyright © 2015年 NBCYL. All rights reserved.
//

#import "NTGMainController.h"
#import "NTGBavBaseController.h"
/**
 * control - 程序主控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGMainController ()

@end

@implementation NTGMainController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self preferredStatusBarStyle];
    [self addChildVCWithSBName:@"Home" title:@"首页" norImageName:@"TabBar1" selectedImageName:@"TabBar1Sel"];
    [self addChildVCWithSBName:@"Classification" title:@"分类" norImageName:@"TabBar2" selectedImageName:@"TabBar2Sel"];
    [self addChildVCWithSBName:@"Discovery" title:@"发现" norImageName:@"TabBar3" selectedImageName:@"TabBar3Sel"];
    [self addChildVCWithSBName:@"Shopping" title:@"购物车" norImageName:@"TabBar4" selectedImageName:@"TabBar4Sel"];
    [self addChildVCWithSBName:@"Mine" title:@"我的" norImageName:@"TabBar5" selectedImageName:@"TabBar5Sel"];
    self.tabBar.tintColor = [UIColor orangeColor];
}

/** 通过Storyboard名字加载控制器 */
- (UIViewController *)addChildVCWithSBName:(NSString *)sbName  title:(NSString *)title norImageName:(NSString *)norImageName selectedImageName:(NSString *)selectedImageName{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
   
    UIViewController *uiViewCtrl = sb.instantiateInitialViewController;
    
    UINavigationController *nav = [[NTGBavBaseController alloc] initWithRootViewController:uiViewCtrl];
    
    [self addChildVCWithController:nav.topViewController title:title norImageName:norImageName selectedImageName:selectedImageName];
    return nav.topViewController;
}

/** 加载控制器 设置标题、图片 */
- (UIViewController *)addChildVCWithController:(UIViewController *)vc  title:(NSString *)title norImageName:(NSString *)norImageName selectedImageName:(NSString *)selectedImageName{
    
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:norImageName];
    
    vc.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:vc.navigationController];
    return vc;
}

@end
