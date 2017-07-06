/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGElderlyFinanceController.h"
#import "NTGSendRequest.h"
#import "NTGElderlyFinanceTableView.h"
#import "NTGPage.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 金融列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGElderlyFinanceController ()<ElderlyFinanceTableViewDelegate>
@property (weak, nonatomic) IBOutlet NTGElderlyFinanceTableView *financeTable;

@end

@implementation NTGElderlyFinanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"养老金融";
    [self initData];
    self.financeTable.delegateFinance = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGPage *page) {
        self.financeTable.finances = page.content;
        if (page.content.count == 0) {
            
            UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.financeTable.tableFooterView = footView;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, footView.frame.size.width, footView.frame.size.height)];
            label.text = @"抱歉，没有找到符合的商品！";
            label.textAlignment = NSTextAlignmentCenter;
            [footView addSubview:label];
            
        }
    };
    [NTGSendRequest elderlyFinanceList:nil success:result];
}

- (IBAction)clickBtn:(id)sender {
    [NTGMBProgressHUD alertView:@"敬请期待!" view:self.view];
}

-(void)clickindexPathRow:(NTGFinance *)finance index:(int)index {
    [NTGMBProgressHUD alertView:@"敬请期待!" view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
