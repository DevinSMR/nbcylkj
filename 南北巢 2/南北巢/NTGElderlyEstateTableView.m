/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGElderlyEstateTableView.h"
#import "NTGElderlyEstateCell.h"

/**
 * view - 地产列表
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGElderlyEstateTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGElderlyEstateTableView

- (void)setSellers:(NSArray *)sellers {
    _sellers = sellers;
    [self reloadData];
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

/** 数据源、代理 */
-(void)awakeFromNib {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight = 102;
    //    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(NTGElderlyEstateCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGElderlyEstateCell *cell =[NTGElderlyEstateCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGElderlyEstateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ElderlyEstateCell"];
    }
    cell.elderlyEstateContent = self.sellers[indexPath.row];
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath!=nil) {
        NTGElderlyEstateCell *cell = (NTGElderlyEstateCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateEld respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegateEld clickindexPathRow:_sellers[indexPath.row] index:(int)indexPath.row];
    }
//    self.index=indexPath;
}

@end
