/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInstitutionTableView.h"
#import "NTGInstitutionCell.h"

/**
 * tableView - 机构列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInstitutionTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NTGInstitutionTableView
- (void)setSellers:(NSArray *)sellers {
    _sellers = sellers;
    [self reloadData];
}

- (void)addSellers:(NSArray *)sellers {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_sellers];
    [temp addObjectsFromArray:sellers];
    _sellers = temp;
    [self reloadData];
}

-(void) clearSellers {
    _sellers = [NSMutableArray array];
    [self reloadData];
}

/** 数据源、代理 */
-(void)awakeFromNib {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight = 102;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(NTGInstitutionCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGInstitutionCell *cell =[NTGInstitutionCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGInstitutionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstitutionCell"];
    }
    cell.seller = self.sellers[indexPath.row];
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath!=nil) {
        NTGInstitutionCell *cell = (NTGInstitutionCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateInstitution respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegateInstitution clickindexPathRow:_sellers[indexPath.row] index:(int)indexPath.row];
    }
}


@end
