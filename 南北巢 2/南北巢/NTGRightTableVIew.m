/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRightTableVIew.h"
#import "NTGSubCell.h"
/**
 * view - 右侧列表
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGRightTableVIew ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NTGRightTableVIew

/** 模型setter方法 */
- (void)setCategoryNavs:(NSArray *)categoryNavs {
    _categoryNavs = categoryNavs;
    [self reloadData];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource=self;
    self.delegate=self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryNavs.count;
}

-(NTGSubCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NTGSubCell *cell =[NTGSubCell cellWithTableView:tableView];

    cell.categoryNav = self.categoryNavs[indexPath.row];
    
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateRight respondsToSelector:@selector(clickRightindexPathRow:index:)]) {
        [_delegateRight clickRightindexPathRow:_categoryNavs[indexPath.row] index:(int)indexPath.row];
    }
    self.index=indexPath;
}

@end
