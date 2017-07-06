/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInstitutionSearchController.h"
#import "NTGSendRequest.h"
#import "NTGPensionAgencyTableView.h"
#import "NTGPage.h"
#import "NTGMBProgressHUD.h"
#import "NTGAgencyPageController.h"

/**
 * control - 机构搜索控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionSearchController ()<PensionAgencyTableViewDelegate>
@property (weak, nonatomic) IBOutlet NTGPensionAgencyTableView *institutionTable;

@end

@implementation NTGInstitutionSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"养老机构搜索结果";
    self.institutionTable.delegateAgency = self;
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
            self.institutionTable.sellers = page.content;
        }else {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.institutionTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"抱歉，没有找到符合的机构！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest institutionSearch:dict success:result];
}

/** 代理方法 */
-(void)clickindexPathRow:(NTGSeller *)seller index:(int)inde {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgencyPage" bundle:nil];
    NTGAgencyPageController *agencyPageController = [storyboard instantiateViewControllerWithIdentifier:@"agencyPageController"];
    agencyPageController.seller = seller;
    [self.navigationController pushViewController:agencyPageController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
