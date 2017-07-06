/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGTravelSearchController.h"
#import "NTGOldTravelTableView.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGMBProgressHUD.h"
#import "NTGTravelDetailController.h"

/**
 * control - 跟团游搜索控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelSearchController ()<OldTravelTableViewDelegate>
@property (weak, nonatomic) IBOutlet NTGOldTravelTableView *travelTable;

@end

@implementation NTGTravelSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"跟团游搜索结果";
    self.travelTable.delegateDock = self;
    [self initData];
    // Do any additional setup after loading the view.
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
            self.travelTable.products = page.content;
            
        }else {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.travelTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"抱歉，没有找到符合的旅游路线！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest tripSearch:dict success:result];
}

/** 请求代理方法 */
-(void)clickDockindexPathRow:(NTGTripContent *)product index:(NSIndexPath *)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGTravelDetail" bundle:nil];
    NTGTravelDetailController *travelDetailController = [storyboard instantiateInitialViewController];
    travelDetailController.trip = product;
    [self.navigationController pushViewController:travelDetailController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
