/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAgencyView.h"
#import "NTGClassCategoryController.h"
#import "NTGBavBaseController.h"

/**
 * view - 养老机构
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGAgencyView

/** 加载Cell */
+ (instancetype)viewWithView {
    NTGAgencyView *agencyView = [[[NSBundle mainBundle]loadNibNamed:@"AgencyView" owner:nil options:nil] lastObject];
    return agencyView;
}

/** 跳转机构 */
- (IBAction)clickBtn:(id)sender {
    UIButton * ub = (UIButton *) sender;
    NSInteger clickBtnTag =[ub tag];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (clickBtnTag == 100) {
//        dict = @{@"temperature":@"10",@"_categoryNav_":@"气温舒适"};
        [dict setValue:@"10" forKey:@"temperature"];
        [dict setValue:@"气温舒适" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 200){
//        dict = @{@"PM2_5":@"10",@"_categoryNav_":@"空气优良"};
        [dict setValue:@"10" forKey:@"PM2_5"];
        [dict setValue:@"空气优良" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 300){
//        dict = @{@"waterQuality":@"10",@"_categoryNav_":@"优质水源"};
        [dict setValue:@"10" forKey:@"waterQuality"];
        [dict setValue:@"优质水源" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 400){
//        dict = @{@"humidity":@"10",@"_categoryNav_":@"温度适宜"};
        [dict setValue:@"10" forKey:@"humidity"];
        [dict setValue:@"温度适宜" forKey:@"_categoryNav_"];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassCategory" bundle:nil];
    NTGClassCategoryController *classCategoryController = [storyboard instantiateInitialViewController];
    classCategoryController.reqParam = dict;
    classCategoryController.isDiscovery = YES;
    classCategoryController.backToPage =^(NSInteger index){
    
        self.backToPage(index);
    };
    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray *childControllers = [tabbarController childViewControllers];
    NTGBavBaseController *hm = childControllers[2];
    [hm pushViewController:classCategoryController animated:YES];
}

@end
