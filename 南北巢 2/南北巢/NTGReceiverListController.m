/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGReceiverListController.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGReceiverContent.h"
#import "NTGReceiverCell.h"
#import "NTGChangeReceiverController.h"

/**
 * control - 收货地址列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReceiverListController ()<UITableViewDataSource,UITableViewDelegate>
/** 收货地址列表 */
@property (weak, nonatomic) IBOutlet UITableView *receiverTable;
//收货地址数组
@property (nonatomic,strong) NSArray *receivers;
@property (nonatomic,strong) UIView *footView;
@end

@implementation NTGReceiverListController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setReceivers:(NSArray *)receivers {
    _receivers = receivers;
    [self.receiverTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    self.receiverTable.dataSource = self;
    self.receiverTable.delegate = self;
    self.receiverTable.rowHeight = 80;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (self.receiver) {
        self.receivers = self.recs;
        for (int i =0; i<self.receivers.count; i++) {
            NTGReceiverContent *receiver = self.receivers[i];
            if (receiver.isDefault) {
                receiver.isDefault = NO;
            }
            if (self.receiver.id == receiver.id) {
                receiver.isDefault = YES;
            }
            [self.receiverTable reloadData];
        }
    }else {
        [self getReceiverList];
    }
   
}

/** 获取地址列表 */
- (void)getReceiverList {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page) {
        self.receivers = page.content;
        if (page.content.count == 0) {
            self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.receiverTable.tableFooterView = self.footView;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.footView.frame.size.width, self.footView.frame.size.height)];
            label.text = @"亲，还没有地址，赶快去新增吧！";
            label.textAlignment = NSTextAlignmentCenter;
            [self.footView addSubview:label];
        }else {
            if (self.footView) {
                [self.footView removeFromSuperview];
            }
        }
    };
    [NTGSendRequest getReceiverList:nil success:result];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receivers.count;
}

- (NTGReceiverCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGReceiverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.receiver = self.receivers[indexPath.row];
    cell.editBtn.tag = cell.receiver.id;
    [cell.editBtn addTarget:self action:@selector(editBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)editBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGChangeReceiver" bundle:nil];
    NTGChangeReceiverController *changeReceiverController = [storyboard instantiateInitialViewController];
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    changeReceiverController.receiverId = [NSString stringWithFormat:@"%ld",(long)tag];
    [self.navigationController pushViewController:changeReceiverController animated:YES];
}

- (void)chooseBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    NTGReceiverCell *cell = (NTGReceiverCell *)btn.superview.superview;
    for (int i =0; i<self.receivers.count; i++) {
        NTGReceiverContent *receiver = self.receivers[i];
        //第二行代码已经更改btn的选中状态，，这里收货地址的选中状态在此基础上再进行非运算
        receiver.isDefault = !btn.selected;
        if ([receiver isEqual:cell.receiver]) {
            receiver.isDefault = btn.selected;
        }
        [self.receiverTable reloadData];
    }
    
    for (int i =0; i<self.receivers.count; i++) {
        NTGReceiverContent *receiver = self.receivers[i];
        if (receiver.isDefault) {
            if (self.returnTextBlock != nil) {
                self.returnTextBlock(receiver);
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/** 新增地址列表 */
- (IBAction)addReceiver:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGChangeReceiver" bundle:nil];
    NTGChangeReceiverController *changeReceiverController = [storyboard instantiateInitialViewController];
    changeReceiverController.receiverId = nil;
    [self.navigationController pushViewController:changeReceiverController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
