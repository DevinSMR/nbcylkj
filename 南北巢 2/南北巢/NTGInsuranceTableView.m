/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInsuranceTableView.h"
#import "NTGInsuranceCell.h"

/**
 * view - 保险列表
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGInsuranceTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGInsuranceTableView

- (void)setSellers:(NSArray *)sellers {
    _sellers = sellers;
    [self reloadData];
}

/** 数据源、代理 */
-(void)awakeFromNib {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight = 103;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void) addSellers:(NSArray *)sellers {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_sellers];
    [temp addObjectsFromArray:sellers];
    _sellers = temp;
    [self reloadData];
}


-(void) clearSellers {
    _sellers = [NSMutableArray array];
    [self reloadData];
}
#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(NTGInsuranceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGInsuranceCell *cell =[NTGInsuranceCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGInsuranceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InsuranceCell"];
    }
    cell.insuranceContent = self.sellers[indexPath.row];
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath!=nil) {
        NTGInsuranceCell *cell = (NTGInsuranceCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateIns respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegateIns clickindexPathRow:_sellers[indexPath.row] index:(int)indexPath.row];
    }
}

@end
