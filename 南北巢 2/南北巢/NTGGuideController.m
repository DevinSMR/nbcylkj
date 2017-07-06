/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGGuideController.h"
#import "NTGGuideCell.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGScenicRegion.h"
#import "NTGNestGuideController.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
#import "NTGGuideTable.h"
#import "NTGNestGuideVC.h"

/**
 * control - 巢友指南控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideController ()<UITableViewDataSource,UITableViewDelegate>
/** 景点列表 */
@property (weak, nonatomic) IBOutlet NTGGuideTable *guideTable;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation NTGGuideController

/** 退出控制器 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_reqParam ||![_reqParam isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *tempReqParam = [NSMutableDictionary dictionary];
        [tempReqParam addEntriesFromDictionary:_reqParam];
        _reqParam = tempReqParam;
    }
    self.guideTable.dataSource = self;
    self.guideTable.delegate = self;
    self.guideTable.rowHeight = 200;
    [self.reqParam setValue:@"1" forKey:@"pageNumber"];
    [self.reqParam setValue:@"3" forKey:@"pageSize"];
    [self initData];
}

- (void)initData {
    // 下拉刷新
    self.guideTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    // 上拉刷新
    self.guideTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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

/** 请求数据 */
- (void)initData:(NTGPullRefresh)action {
    self.navigationItem.title = [_reqParam valueForKey:@"_categoryNav_"];
    [NTGSendRequest getGuide:_reqParam success:^(NTGPage *page) {
//        self.guideTable.scenicRegions = page.content;
        [self updateTableView:page.content action:action state:YES];
    }];
}

- (void)updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新
        if (state) {
            [self.guideTable clearScenicRegions];
        }
        
        if (action == NTGPulRefreshDown) {
            [self.guideTable.mj_header endRefreshing];
        }
    }else{//上拉加载
        if (sellers.count == 0) {
            [self.guideTable.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.guideTable.mj_footer endRefreshing];
        }
    }
    if (state) {
        NSString *pageNumber = [self.reqParam valueForKey:@"pageNumber"];
        pageNumber = [NSString stringWithFormat:@"%d",([pageNumber intValue] + 1) ];
        [self.reqParam setValue:pageNumber forKey:@"pageNumber"];
        [self.guideTable addScenicRegions:sellers];
    }
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guideTable.scenicRegions.count;
}

- (NTGGuideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NTGGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NTGScenicRegion *scenicRegion = self.guideTable.scenicRegions[indexPath.row];
    cell.scenicRegion = scenicRegion;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NTGNestGuideVC *VC = [[NTGNestGuideVC alloc] init];
//    NTGScenicRegion *region = self.guideTable.scenicRegions[indexPath.row];
//    VC.scenicRegion = region;
//    VC.headLine = [_reqParam valueForKey:@"_categoryNav_"];
//    [self.navigationController pushViewController:VC animated:YES];
//
//
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"nestGuideController"]) {
        NTGNestGuideController *nestGuideController = segue.destinationViewController;
        NTGGuideCell *cell = (NTGGuideCell *)sender;
        nestGuideController.scenicRegion = cell.scenicRegion;
        nestGuideController.headLine = [_reqParam valueForKey:@"_categoryNav_"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
