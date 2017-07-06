/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGElderlyFinanceTableView.h"
#import "NTGFinanceCell.h"

/**
 * view - 金融列表
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGElderlyFinanceTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NTGElderlyFinanceTableView

-(void)setFinances:(NSArray *)finances {
    _finances = finances;
    [self reloadData];
}
/** 数据源、代理 */
-(void)awakeFromNib {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight = 90;
    //    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.finances.count;
}

-(NTGFinanceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGFinanceCell *cell =[NTGFinanceCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGFinanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NTGFinanceCell"];
    }
    cell.finance = self.finances[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath!=nil) {
        NTGFinanceCell *cell = (NTGFinanceCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateFinance respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegateFinance clickindexPathRow:_finances[indexPath.row] index:(int)indexPath.row];
    }
}

@end
