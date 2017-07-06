/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGPensionAgencyController.h"
#import "NTGPensionAgencyTableView.h"
#import "NTGAgencyPageController.h"
#import "NTGSendRequest.h"
#import <MJRefresh.h>
#import "NTGConstant.h"

/**
 * control - 机构控制器
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGPensionAgencyController ()

@end

@implementation NTGPensionAgencyController

- (void)viewDidLoad {
    
    if (!_reqParam ||![_reqParam isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *tempReqParam = [NSMutableDictionary dictionary];
        [tempReqParam addEntriesFromDictionary:_reqParam];
        _reqParam = tempReqParam;
    }
    
    [self.reqParam setValue:@"1" forKey:@"pageNumber"];
    [self.reqParam setValue:@"10" forKey:@"pageSize"];
    [super viewDidLoad];
    self.pensionAgencyTableView.delegateAgency = self;
    
    // 下拉刷新
    self.pensionAgencyTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.pensionAgencyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshUp];
    }];
    
    [self pageInitData:NTGPulRefreshInit];
}


- (void) pageInitData :(NTGPullRefresh)action {
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown) {
         [self.reqParam setObject:@"1" forKey:@"pageNumber"];
    }
    
    [self initData:action];
}


- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新、初始化加载
        if (state) {
            [self.pensionAgencyTableView clearSellers];
        }
        
        if (action == NTGPulRefreshDown) {
            [self.pensionAgencyTableView.mj_header endRefreshing];
        }
        
    }
    else{//上拉加载
        if (sellers.count == 0) {
            [self.pensionAgencyTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.pensionAgencyTableView.mj_footer endRefreshing];
        }
    }
    if (state) {
        NSString *pageNumber = [self.reqParam valueForKey:@"pageNumber"];
        pageNumber = [NSString stringWithFormat:@"%d",([pageNumber intValue] + 1) ];
        [self.reqParam setValue:pageNumber forKey:@"pageNumber"];
        [self.pensionAgencyTableView addSellers:sellers];
    }
}

/** 请求数据 */
- (void)initData:(NTGPullRefresh)action {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/** 代理方法 */
-(void)clickindexPathRow:(NTGSeller *)seller index:(int)inde {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgencyPage" bundle:nil];
    NTGAgencyPageController *agencyPageController = [storyboard instantiateViewControllerWithIdentifier:@"agencyPageController"];
    agencyPageController.seller = seller;
    [self.navigationController pushViewController:agencyPageController animated:YES];
}

@end
