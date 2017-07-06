/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductTableView.h"
#import "NTGproductCell.h"

/**
 * tableView - 商品列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGProductTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGProductTableView

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
    self.rowHeight = 88;
    //    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(NTGProductCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGProductCell *cell =[NTGProductCell cellWithTableView:tableView reuseID:@"ProductCell" nibNamed:@"NTGProductCell"];
    if (cell == nil) {
        cell = [[NTGProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
    }
    cell.productContent = self.sellers[indexPath.row];
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath != nil) {
        NTGProductCell *cell = (NTGProductCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegatePro respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegatePro clickindexPathRow:_sellers[indexPath.row] index:(int)indexPath.row];
    }
}
@end
