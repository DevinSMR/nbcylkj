/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAttributeView.h"
#import "NTGAttributeCell.h"

/**
 * view - 筛选分类列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAttributeView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NTGAttributeView

-(void)setAttibuteOptions:(NSArray *)attibuteOptions {
    _attibuteOptions = attibuteOptions;
    [self.attributeTable reloadData];
}

-(void)awakeFromNib {
//    self.selectPosition = -1;
    self.attributeTable.delegate = self;
    self.attributeTable.dataSource = self;
    self.attributeTable.rowHeight = 44;
}

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGAttributeView *attributeView = [[[NSBundle mainBundle]loadNibNamed:@"NTGAttributeView" owner:nil options:nil] lastObject];
    return attributeView;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attibuteOptions.count;
}

-(NTGAttributeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGAttributeCell *cell =[NTGAttributeCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGAttributeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NTGAttributeCell"];
//        cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"NTGAttributeCell%ld%ld",indexPath.section,indexPath.row] ];
//        cell = [tableView cellForRowAtIndexPath:indexPath];
    }
    cell.attibuteOption = self.attibuteOptions[indexPath.row];
    return cell;
}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath!=nil) {
        NTGAttributeCell *cell = (NTGAttributeCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_delegateAttribute respondsToSelector:@selector(clickAttributeViewIndexPathRow:index:)]) {
        [_delegateAttribute clickAttributeViewIndexPathRow:_attibuteOptions[indexPath.row] index:indexPath];
    }
}

     
@end
