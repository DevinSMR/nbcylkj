/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGDockTableVIew.h"
#import "NTGclassCell.h"
/**
 * view - 左侧列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGDockTableVIew ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGDockTableVIew

/** 模型setter方法 */
- (void)setCategoryNavs:(NSArray *)categoryNavs {
    _categoryNavs = categoryNavs;
    [self reloadData];
    if(self.categoryNavs.count>0) {
        [self  selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
        [self tableView:self didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];//实现点击第一行所调用的方法
    }
}

/** 数据源、代理 */
-(void)awakeFromNib {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight = 55; 
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryNavs.count;
}

-(NTGclassCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGclassCell *cell =[tableView dequeueReusableCellWithIdentifier:@"classCell"];
    if (cell == nil) {
        cell = [[NTGclassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"classCell"];
    }
    cell.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    cell.boarderView.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    cell.categoryNav = self.categoryNavs[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegateDock respondsToSelector:@selector(clickDockindexPathRow:index:)]) {
        [_delegateDock clickDockindexPathRow:_categoryNavs[indexPath.row] index:indexPath];
    }
    NTGclassCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NTGclassCell *cell = (NTGclassCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.lblName.textColor = [UIColor colorWithRed:248.0/255 green:111.0/255 blue:78.0/255 alpha:1];
    cell.boarderView.backgroundColor = [UIColor colorWithRed:248.0/255 green:111.0/255 blue:78.0/255 alpha:1];
    NSArray *allCells = self.visibleCells;
    for (int i=0; i<allCells.count; i++) {
        NTGclassCell *otherCell = self.visibleCells[i];
        if (otherCell != cell) {
            otherCell.lblName.textColor = [UIColor darkGrayColor];
            otherCell.boarderView.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
        }
    }
//    self.index=indexPath;
}

@end
