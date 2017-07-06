/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGFilterView.h"
#import "NTGFilterCell.h"
//#import "NTGAttributeView.h"

/**
 * view - 筛选
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGFilterView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NTGFilterView

-(void)setAttributes:(NSArray *)attributes {
    _attributes = attributes;
    
    [self.termListTable reloadData];
}

-(void)awakeFromNib {
    self.termListTable.delegate = self;
    self.termListTable.dataSource = self;
    self.termListTable.rowHeight = 44;
}

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGFilterView *filterView = [[[NSBundle mainBundle]loadNibNamed:@"NTGFilterView" owner:nil options:nil] lastObject];
    return filterView;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attributes.count;
}

-(NTGFilterCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGFilterCell *cell =[NTGFilterCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NTGFilterCell"];
    }
    cell.attribute = self.attributes[indexPath.row];
//    cell.value.text =
 
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGFilterCell *cell = nil;
    if (indexPath!=nil) {
        cell = (NTGFilterCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateFilter respondsToSelector:@selector(clickFilterViewIndexPathRow:index:)]) {
        [_delegateFilter clickFilterViewIndexPathRow:_attributes[indexPath.row] index:(NSIndexPath *)indexPath];
    }
    
}

@end
