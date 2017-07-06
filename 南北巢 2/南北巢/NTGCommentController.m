/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCommentController.h"
#import "EQPageCycleSize.h"
#import "NTGReviewLevel.h"
#import "NTGSendRequest.h"
#import "NTGCommentDetailCell.h"
#import "NTGPage.h"

/**
 * control - 评论
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentController ()<UITableViewDataSource>
/** 滚动条 */
@property (weak, nonatomic) IBOutlet UIView *animateView;
/** 全部评论 */
@property (weak, nonatomic) IBOutlet UILabel *lblAll;
/** 好评 */
@property (weak, nonatomic) IBOutlet UILabel *lblPositive;
/** 中评 */
@property (weak, nonatomic) IBOutlet UILabel *lblModerate;
/** 差评 */
@property (weak, nonatomic) IBOutlet UILabel *lblNegative;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic,strong) NSArray *reviewContents;
@property (nonatomic,strong) UIView *footView;
@end

@implementation NTGCommentController

-(void)setReviewContents:(NSArray *)reviewContents {
    _reviewContents = reviewContents;
    [self.commentTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论详情";
    [self initData];
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id};
    }else {
        dict = @{@"id":self.id};
    }
    [self initReviewList:dict];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initData {
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id};
    }else {
        dict = @{@"id":self.id};
    }
    [NTGSendRequest getReviewLevel:dict successBack:^(NTGReviewLevel *level) {
        self.lblAll.text = [NSString stringWithFormat:@"%ld",level.allCount];
        self.lblPositive.text = [NSString stringWithFormat:@"%ld",level.positiveCount];
        self.lblModerate.text = [NSString stringWithFormat:@"%ld",level.moderateCount];
        self.lblNegative.text = [NSString stringWithFormat:@"%ld",level.negativeCount];
    }];
}

- (void)initReviewList:(NSDictionary *)dict {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGPage *page) {
        self.reviewContents = page.content;
//        UIView *footView = nil;
        if (page.content.count == 0) {
            self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.commentTable.tableFooterView = self.footView;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.footView.frame.size.width, self.footView.frame.size.height)];
            label.text = @"抱歉，没有找到符合的商品！";
            label.textAlignment = NSTextAlignmentCenter;
            [self.footView addSubview:label];
        }else {
            if (self.footView) {
                [self.footView removeFromSuperview];
            }
        }
    };
    [NTGSendRequest reviewList:dict success:result];
}

/** 全部评论 */
- (IBAction)allBtn:(id)sender {
    self.animateView.frame = CGRectMake(0, 110, UI_CURRENT_SCREEN_WIDTH*0.25, 1);
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id};
    }else {
        dict = @{@"id":self.id};
    }
    [self initReviewList:dict];
}

/** 好评 */
- (IBAction)positiveBtn:(id)sender {
    self.animateView.frame = CGRectMake(UI_CURRENT_SCREEN_WIDTH*0.25, 110, UI_CURRENT_SCREEN_WIDTH*0.25, 1);
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id,@"type":@"positive"};
    }else {
        dict = @{@"id":self.id,@"type":@"positive"};
    }
    [self initReviewList:dict];
}

/** 中评 */
- (IBAction)moderateBtn:(id)sender {
    self.animateView.frame = CGRectMake(UI_CURRENT_SCREEN_WIDTH*0.5, 110, UI_CURRENT_SCREEN_WIDTH*0.25, 1);
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id,@"type":@"moderate"};
    }else {
        dict = @{@"id":self.id,@"type":@"moderate"};
    }
    [self initReviewList:dict];
}

/** 差评 */
- (IBAction)negativeBtn:(id)sender {
    self.animateView.frame = CGRectMake(UI_CURRENT_SCREEN_WIDTH*0.75, 110, UI_CURRENT_SCREEN_WIDTH*0.25, 1);
    NSDictionary *dict = nil;
    if (self.tag) {
        dict = @{@"sellerId":self.id,@"type":@"negative"};
    }else {
        dict = @{@"id":self.id,@"type":@"negative"};
    }
    [self initReviewList:dict];
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviewContents.count;
}

-(NTGCommentDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGCommentDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:@"NTGCommentDetailCell"];
    cell.reviewContent = self.reviewContents[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
