/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSpecificationTable.h"
#import "NTGSpecificationValueCell.h"
#import "NTGProCountCell.h"
/**
 * view - 规格尺寸列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSpecificationTable ()<UITableViewDataSource,UITableViewDelegate,changeProductCountDelegate>
@property (nonatomic,strong) NTGSpecificationValueCell *countCell;
@property (nonatomic,strong) NSString *proCount;
@end

@implementation NTGSpecificationTable

-(void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
    self.proCount = @"1";
}

-(void)setEffectiveSpecifications:(NSArray *)effectiveSpecifications {
    _effectiveSpecifications = effectiveSpecifications;
    [self reloadData];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.effectiveSpecifications.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NTGSpecificationValueCell *cell = [NTGSpecificationValueCell cellWithTableView:tableView];
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NTGSpecificationValueCell" forIndexPath:indexPath];
        }
        cell.specificationBean = self.effectiveSpecifications[indexPath.row];
        
        return cell;

    }else{
        NTGProCountCell  *cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGProCountCell" owner:nil options:nil] firstObject];
;
//        NTGSpecificationValueCell *cell = [NTGSpecificationValueCell countCellWithTableView:tableView];
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        }

        [cell.plusBtn addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
        [cell.minusBtn addTarget:self action:@selector(reduceCount:) forControlEvents:UIControlEventTouchUpInside];
        cell.countLb.text = self.proCount;

        return cell;
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NTGSpecificationValueCell *cell = (NTGSpecificationValueCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        int count = (int)cell.specificationBean.specificationValues.count;
        CGFloat rowHeight = 0.0f;
        if (count<=5) {
            rowHeight = 70;
        }
        if(count > 5) {
            rowHeight = 105;
        }
        return rowHeight;
    }else{
    
        return 70;
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(void)addCount:(UIButton *)btn{
    NTGProCountCell *cell = (NTGProCountCell *)btn.superview.superview;
    NSString *count = cell.countLb.text;
    int num = [count intValue];
    num = num + 1;
    cell.countLb.text = [NSString stringWithFormat:@"%d",num];
    self.choseCount = cell.countLb.text;
    
    self.countBlock(self.choseCount);
    self.proCount = cell.countLb.text;


}


-(void)reduceCount:(UIButton *)btn{
    NTGProCountCell *cell = (NTGProCountCell *)btn.superview.superview;
    NSString *count = cell.countLb.text;
    int num = [count intValue];
    num = num - 1;
    if (num < 1) {
        num = 1;
    }
    cell.countLb.text = [NSString stringWithFormat:@"%d",num];
    self.choseCount = cell.countLb.text;
    self.countBlock(self.choseCount);
    self.proCount = cell.countLb.text;
}


@end
