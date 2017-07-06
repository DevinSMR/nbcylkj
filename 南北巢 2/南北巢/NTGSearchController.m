/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSearchController.h"
#import "NTGInstitutionSearchController.h"
#import "NTGTravelSearchController.h"
#import "NTGProSearchController.h"
#import "NTGMBProgressHUD.h"
#import "NTGSendRequest.h"
#import "NTGIntegration.h"
#import "HeadView.h"

/**
 * control - 搜索控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSearchController () <HeadViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keyWord;
@property (weak, nonatomic) IBOutlet UITableView *integrationTable;

@property (nonatomic,strong) NSArray *integrations;
@property (nonatomic,strong) HeadView *headView;
@end

@implementation NTGSearchController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.keyWord becomeFirstResponder];
    self.integrationTable.sectionHeaderHeight = 40;
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSArray *integrations) {
        self.integrations = integrations;
    };
    [NTGSendRequest integrationSearch:nil success:result];

}

-(void)setIntegrations:(NSArray *)integrations {
    _integrations = integrations;
    [self.integrationTable reloadData];
}

- (IBAction)searchBrn:(id)sender {
    if (self.keyWord.text == nil) {
        [NTGMBProgressHUD alertView:@"请输入关键词" view:self.view];
        return;
    }
    NSDictionary *dict = @{@"keyword":self.keyWord.text};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSArray *integrations) {
        if (integrations.count == 0) {
           [NTGMBProgressHUD alertView:@"暂无结果" view:self.view];
        }
        self.integrations = integrations;
    };
    [NTGSendRequest integrationSearch:dict success:result];
}

#pragma 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.integrations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NTGIntegration *integration = self.integrations[section];
    NSInteger count = integration.isOpened ? integration.children.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NTGIntegration *integration = self.integrations[indexPath.section];
    NTGIntegration *integ = integration.children[indexPath.row];
    if (integ.name) {
        cell.textLabel.text = [integ.name stringByAppendingString:[NSString stringWithFormat:@"(%ld)",integ.num]];
    }else {
        cell.textLabel.text = [@"养老机构" stringByAppendingString:[NSString stringWithFormat:@"(%ld)",integ.num]];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.integration = _integrations[section];
    self.headView = headView;
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGIntegration *integration = self.integrations[indexPath.section];
    NTGIntegration *integ = integration.children[indexPath.row];
    if ([integ.category isEqualToString:@"institution"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"InstitutionSearch" bundle:nil];
        NTGInstitutionSearchController *institutionSearchController = [storyboard instantiateInitialViewController];
        institutionSearchController.keyword = self.keyWord.text;
        [self.navigationController pushViewController:institutionSearchController animated:YES];
    }else if ([integ.category isEqualToString:@"trip"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TravelSearch" bundle:nil];
        NTGTravelSearchController *travelSearchController = [storyboard instantiateInitialViewController];
        travelSearchController.keyword = self.keyWord.text;
        [self.navigationController pushViewController:travelSearchController animated:YES];
    }else if ([integ.category isEqualToString:@"product"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProSearch" bundle:nil];
        NTGProSearchController *proSearchController = [storyboard instantiateInitialViewController];
        proSearchController.keyword = self.keyWord.text;
        [self.navigationController pushViewController:proSearchController animated:YES];
    }else  {
        [NTGMBProgressHUD alertView:@"敬请期待！" view:self.view];
    }
}

- (void)clickHeadView {
    [self.integrationTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
