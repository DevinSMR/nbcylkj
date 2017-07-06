/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGArtidesView.h"
#import "NTGBavBaseController.h"
#import "NTGProductController.h"

/**
 * view - 养生用品视图
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGArtidesView

/** 加载视图 */
+ (instancetype)viewWithView {
    NTGArtidesView *artidesView = [[[NSBundle mainBundle]loadNibNamed:@"ArtidesView" owner:nil options:nil] lastObject];
    return artidesView;
}

/** 商品 */
- (IBAction)clickBtn:(id)sender {
    UIButton * ub = (UIButton *) sender;
    NSInteger clickBtnTag =[ub tag];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (clickBtnTag == 100) {
//        dict = @{@"productCategoryId": @"88",@"_categoryNav_":@"食品保健"};
        [dict setValue:@"88" forKey:@"productCategoryId"];
        [dict setValue:@"食品保健" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 200){
//        dict = @{@"productCategoryId":@"182",@"_categoryNav_":@"老年护理"};
        [dict setValue:@"182" forKey:@"productCategoryId"];
        [dict setValue:@"老年护理" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 300){
//        dict = @{@"productCategoryId":@"227",@"_categoryNav_":@"老年服装"};
        [dict setValue:@"227" forKey:@"productCategoryId"];
        [dict setValue:@"老年服装" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 400){
//        dict = @{@"productCategoryId":@"90",@"_categoryNav_":@"保健器材"};
        [dict setValue:@"90" forKey:@"productCategoryId"];
        [dict setValue:@"保健器材" forKey:@"_categoryNav_"];
    }
    else if (clickBtnTag == 500){
//        dict = @{@"productCategoryId":@"100",@"_categoryNav_":@"礼品礼盒"};
        [dict setValue:@"100" forKey:@"productCategoryId"];
        [dict setValue:@"礼品礼盒" forKey:@"_categoryNav_"];
    }else if (clickBtnTag == 600){
//        dict = @{@"productCategoryId":@"116",@"_categoryNav_":@"老年用品"};
        [dict setValue:@"116" forKey:@"productCategoryId"];
        [dict setValue:@"老年用品" forKey:@"_categoryNav_"];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProduct" bundle:nil];
    NTGProductController *productController = [storyboard instantiateInitialViewController];
    productController.reqParam = dict;
    productController.isDiscovery = YES;
    productController.backToPage = ^(NSInteger index){
    
        self.backToPage(index);
    };
    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray *childControllers = [tabbarController childViewControllers];
    NTGBavBaseController *hm = childControllers[2];
    [hm pushViewController:productController animated:YES];
}

@end
