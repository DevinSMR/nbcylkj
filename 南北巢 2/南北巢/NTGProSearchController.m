/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProSearchController.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGProductTableView.h"
#import "NTGMBProgressHUD.h"
#import "NTGProductDetailController.h"

/**
 * control - 保健用品搜索控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGProSearchController ()<ProductTableViewDelegate>
@property (weak, nonatomic) IBOutlet NTGProductTableView *productTable;

@end

@implementation NTGProSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"养生保健搜索结果";
    self.productTable.delegatePro = self;
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

/** 请求数据 */
- (void) initData {
    NSDictionary *dict = @{@"keyword":self.keyword};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page) {
        if (page.content.count>0) {
            self.productTable.sellers = page.content;
        }else {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.productTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"抱歉，没有找到符合的商品！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest productSearch:dict success:result];
}

/** 选中代理方法 */
-(void)clickindexPathRow:(NTGProductContent *)product index:(int)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductDetail" bundle:nil];
    NTGProductDetailController *productDetailController = [storyboard instantiateInitialViewController];
    productDetailController.product = product;
    [self.navigationController pushViewController:productDetailController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
