/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOldTravelTableView.h"
#import "NTGOldTravelViewCell.h"

/**
 * view - 老年旅游列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGOldTravelTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGOldTravelTableView

/** 模型setter */
-(void)setProducts:(NSArray *)products {
    _products = products;
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
    return self.products.count;
}

-(NTGOldTravelViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGOldTravelViewCell *cell =[NTGOldTravelViewCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGOldTravelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oldTravelViewCell"];
    }
    cell.product = self.products[indexPath.row];
    return cell;
}


- (void)addProducts:(NSArray *)products {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_products];
    [temp addObjectsFromArray:products];
    _products = temp;
    [self reloadData];
}

-(void) clearProducts {
    _products = [NSMutableArray array];
    [self reloadData];
}


/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateDock respondsToSelector:@selector(clickDockindexPathRow:index:)]) {
        [_delegateDock clickDockindexPathRow:_products[indexPath.row] index:indexPath];
    }
//    self.index=indexPath;
}
@end
