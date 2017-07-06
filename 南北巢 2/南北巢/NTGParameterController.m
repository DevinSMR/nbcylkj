/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGParameterController.h"
#import "NTGParameterCell.h"
#import "NTGParameterGroup.h"
#import "NTGProductCategory.h"

/**
 * control - 商品规格参数
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGParameterController ()<UITableViewDataSource>
/** 参数列表 */
@property (weak, nonatomic) IBOutlet UITableView *parameterTable;

@end

@implementation NTGParameterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"规格参数";
    self.parameterTable.dataSource = self;
    [self.parameterTable reloadData];
    // Do any additional setup after loading the view.
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paramValue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parameterCell"];
    cell.parameter = self.paramValue[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
