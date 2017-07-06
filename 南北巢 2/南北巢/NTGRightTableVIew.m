/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRightTableVIew.h"
#import "NTGSubCell.h"
#import "NTGSectionCell.h"
#import "NTGThirdItem.h"
#import <UIImageView+WebCache.h>
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
    if (_categoryNavs != categoryNavs) {
        _categoryNavs = categoryNavs;
        [self reloadData];
    }
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource=self;
    self.delegate=self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = self.tableFooterView;
   view.frame =CGRectMake(0, 0, self.frame.size.width, 49);
    view.backgroundColor = [UIColor whiteColor];
    
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _isThree ? 1: self.categoryNavs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isThree) {
         NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//        NSString *CellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NTGCategoryNavigation *category = self.categoryNavs[indexPath.section];
        //行数
        NSInteger number = category.children.count % 3 ? category.children.count/3 + 1:category.children.count/3;
        CGFloat width = (tableView.frame.size.width - 20) / 3;
        NSLog(@"%ld",category.children.count / 3 + 1);

        for (int i = 0; i < number; i++) {
            for (int j = 0; j < 3; j++) {
                if ( i * 3 + j <category.children.count) {
                    
                    
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(j * (width + 10),i * (width + 18 + 12) , width, width + 18 )];
                    view.backgroundColor = [UIColor redColor];
                    [cell.contentView addSubview:view];
                    
                    
                    NTGThirdItem *item = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil] lastObject];
                    item.frame = CGRectMake(0,0 , width, width + 18);
                    NTGCategoryNavigation *itemModel = category.children[i * 3 + j];
                    NSLog(@"%@",itemModel.name);
                    item.title.text = itemModel.name;
                    item.imageView.image = nil;
                    [item.imageView sd_setImageWithURL:[NSURL URLWithString:itemModel.miniLogo]];
                    [view addSubview:item];
                    [item.clickBtn addTarget:self action:@selector(pushToProduct) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                }
            }
        }
        
             cell.selectionStyle =UITableViewCellSelectionStyleNone;

        return cell;
    }else{
        NTGSubCell *cell =[NTGSubCell cellWithTableView:tableView];
        
        cell.categoryNav = self.categoryNavs[indexPath.row];
             cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }
    
}
//增加第三级分类
-(void)pushToProduct{

//    [self.delegateRight clickRightindexPathRow:<#(NTGCategoryNavigation *)#> index:<#(int)#>]
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_isThree) {
        NTGSectionCell *sectionCell = [[[NSBundle mainBundle] loadNibNamed:@"NTGSectionCell" owner:nil options:nil] lastObject];
        NTGCategoryNavigation *navigation = _categoryNavs[section];
        
        sectionCell.sectionTitle.text = navigation.name;
        return sectionCell;
    }
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return _isThree ? 52 : CGFLOAT_MIN;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;

}
//-(void)setTableFooterView:(UIView *)tableFooterView{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
//    view.backgroundColor = [UIColor whiteColor];
//    [tableFooterView addSubview:view];
//
// 
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return _isThree ?_categoryNavs.count:1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isThree) {
        NTGCategoryNavigation *model = _categoryNavs[indexPath.section];
        NSInteger number = model.children.count % 3 ? model.children.count/3 + 1:model.children.count/3;
        CGFloat width = (tableView.frame.size.width - 20) / 3;
        CGFloat height = number > 1 ? number * (width + 18) + (number - 1) * 10:number * (width + 18) + (number - 1);

        return height + 3;
        
    }else{
    
        return 82;
    }
//    return _isThree ? 300:82;

}

/** 选中行代理方法 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isThree) {
        return;
    }
    if ([_delegateRight respondsToSelector:@selector(clickRightindexPathRow:index:)]) {
        [_delegateRight clickRightindexPathRow:_categoryNavs[indexPath.row] index:(int)indexPath.row];
    }
    self.index=indexPath;
}

@end
