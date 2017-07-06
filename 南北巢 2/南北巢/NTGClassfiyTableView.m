//
//  NTGClassfiyTableView.m
//  南北巢
//
//  Created by nbc on 16/7/12.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGClassfiyTableView.h"
#import "NTGClassfiyCell.h"
@interface NTGClassfiyTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *classfiyView;
@property (nonatomic,strong) UIButton *tmpBtn;
@end
@implementation NTGClassfiyTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) {
       // self = [[NTGClassfiyTableView alloc] initWithFrame:frame];
       // [self addClassfiyView:frame];
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        
    }
   return self;

}
-(void)setClassfiyArray:(NSMutableArray *)classfiyArray

{
    _classfiyArray = classfiyArray;
    [self.classfiyView reloadData];
    
}
-(void)addClassfiyView :(CGRect)frame{
    _classfiyView = [[UITableView alloc] initWithFrame:frame];
    _classfiyView.delegate = self;
    _classfiyView.dataSource = self;
    [self addSubview:_classfiyView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGClassfiyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"classfiyCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGClassfiyCell" owner:nil options:nil]lastObject];
    }
    if (indexPath.row == 0) {
        cell.selectBtn.selected = YES;
    }
    [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)selectBtnAction:(UIButton *)btn{
    if (self.tmpBtn == nil) {
        btn.selected = YES;
        self.tmpBtn = btn;
    }else if(!self.tmpBtn && self.tmpBtn != btn){
        self.tmpBtn.selected = NO;
        btn.selected = YES;
        self.tmpBtn = btn;
    }
    self.hidden = YES;
}
@end
