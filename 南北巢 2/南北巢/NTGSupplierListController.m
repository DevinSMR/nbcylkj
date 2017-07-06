/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSupplierListController.h"
#import "NTGSendRequest.h"
#import "NTGSupplierCell.h"
#import "NTGSupplier.h"
#import "NTGSupplierDetailController.h"

/**
 * control - 分销商列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSupplierListController ()<UITableViewDataSource,UITableViewDelegate>
/** 分销商列表 */
@property (weak, nonatomic) IBOutlet UITableView *supplierTable;
@property (nonatomic,strong) NSArray *suppliers;
@property (nonatomic,strong) NTGSupplier *supplier;
@end

@implementation NTGSupplierListController

- (void)setSuppliers:(NSArray *)suppliers {
    _suppliers = suppliers;
    [self.supplierTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的分销商";
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSArray *suppliers) {
        self.suppliers = suppliers;
    };
    [NTGSendRequest supplierList:nil success:result];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suppliers.count;
}

- (NTGSupplierCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.supplier = self.suppliers[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/** 详情 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NTGSupplierCell *cell = [[NTGSupplierCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NTGSupplierCell *cell = (NTGSupplierCell *)sender;
    if ([segue.identifier isEqualToString:@"cell"]) {
        NTGSupplierDetailController *supplierDetailController = segue.destinationViewController;
        supplierDetailController.supplier = cell.supplier;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
