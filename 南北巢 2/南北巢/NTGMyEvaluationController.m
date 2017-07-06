/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMyEvaluationController.h"
#import "NTGEvaluationCell.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGOrderItem.h"
#import "NTGReviewViewController.h"
#import "NTGReviewSaveController.h"

/**
 * control - 我的评价
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMyEvaluationController ()<UITableViewDataSource>
/** 评价列表 */
@property (weak, nonatomic) IBOutlet UITableView *evalutionTable;

/** 模型数组 */
@property (nonatomic,strong) NSArray *orderItems;
@end

@implementation NTGMyEvaluationController

- (void)setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self.evalutionTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的评价";
    self.evalutionTable.dataSource = self;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initData];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 从后天获取数据 */
-(void)initData {
    NSDictionary *dict = nil;
    if (self.orderSn) {
        dict = @{@"orderSn":self.orderSn};
    }else {
        dict = nil;
    }
    NTGBusinessResult *r = [[NTGBusinessResult alloc]initWithNavController:self.navigationController removePreCtrol:YES];
    r.onSuccess = ^(NTGPage *page) {
        self.orderItems = page.content;
        if (page.content.count == 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.evalutionTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"亲，还没有评价，赶快去评价吧！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest getReviewList:dict success:r];
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderItems.count;
}

-(NTGEvaluationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGEvaluationCell *cell =[tableView dequeueReusableCellWithIdentifier:@"evaluationCell"];
    cell.orderItem = self.orderItems[indexPath.row];
    [cell.reviewBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickBtn:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"查看评价"]) {
        [self performSegueWithIdentifier:@"reviewView" sender:btn];
    }else if ([btn.titleLabel.text isEqualToString:@"我要评价"]) {
        [self performSegueWithIdentifier:@"reviewSave" sender:btn];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NTGEvaluationCell *cell = (NTGEvaluationCell *)btn.superview.superview;\
    if ([btn.titleLabel.text isEqualToString:@"查看评价"]) {
        NTGReviewViewController *reviewViewController = segue.destinationViewController;
        reviewViewController.reviewId = [NSString stringWithFormat:@"%ld",cell.orderItem.reviewId];
    }else if ([btn.titleLabel.text isEqualToString:@"我要评价"]) {
        NTGReviewSaveController *reviewSaveController = segue.destinationViewController;
        reviewSaveController.productId = [NSString stringWithFormat:@"%ld",cell.orderItem.product.id];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
