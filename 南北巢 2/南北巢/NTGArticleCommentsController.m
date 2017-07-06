//
//  NTGArticleCommentsController.m
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGArticleCommentsController.h"
#import "NTGArticleCommentsCell.h"
#import "NTGPublishCommentController.h"
#import "NTGCommentReplysController.h"
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticleDetail.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
@interface NTGArticleCommentsController ()<UITableViewDelegate,UITableViewDataSource,replyDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *commentsArray;

@property (nonatomic,strong) NSMutableDictionary *reqParam;
@end

@implementation NTGArticleCommentsController
- (IBAction)backToAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (self.comments == nil) {
        [self initData];

    }else{
    
        self.commentsArray = (NSMutableArray *)self.comments.content;
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.commentsArray = [NSMutableArray array];
    self.reqParam = [NSMutableDictionary dictionary];
    // 下拉刷新
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshUp];
    }];
    
//    [self pageInitData:NTGPulRefreshInit];
}

- (void) pageInitData :(NTGPullRefresh)action {
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown) {
        [self.reqParam setObject:@"1" forKey:@"pageNumber"];
    }
    
    [self initData:action];
}

/** 更新数据 */
- (void)initData:(NTGPullRefresh)action{
    if (action == NTGPulRefreshInit || action == NTGPulRefreshDown ) {
        [self.reqParam setObject:@"1" forKey:@"pageNumber"];
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:NO];
        result.onSuccess = ^(NTGMemberArticleDetail *articleDetail){
            
            [self updateTableView:articleDetail.memberComments.content action:action state:YES];
        };
        NSString *string = [NSString stringWithFormat:@"%ld",self.memberArticleId];
        [self.reqParam setValue:string forKey:@"memberArticleId"];
        [NTGSendRequest getMemBerArticleDetail:self.reqParam success:result];
    }else {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:NO];
        result.onSuccess = ^(NTGMemberArticleDetail *articleDetail){
            
            [self updateTableView:articleDetail.memberComments.content action:action state:YES];
        };
        NSString *string = [NSString stringWithFormat:@"%ld",self.memberArticleId];
        [self.reqParam setValue:string forKey:@"memberArticleId"];
        [NTGSendRequest getMemBerArticleDetail:self.reqParam success:result];
    }
}

- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新、初始化加载
        if (state) {
            [self clearData];
        }
        
        if (action == NTGPulRefreshDown) {
            [self.tableView.mj_header endRefreshing];
        }
        
    }
    else{//上拉加载
        if (sellers.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }
    if (state) {
        NSString *pageNumber = [self.reqParam valueForKey:@"pageNumber"];
        pageNumber = [NSString stringWithFormat:@"%d",([pageNumber intValue] + 1) ];
        [self.reqParam setValue:pageNumber forKey:@"pageNumber"];
        [self addArray:sellers];
    }
}

-(void)clearData{
    
    self.commentsArray = [NSMutableArray array];
    [self.tableView reloadData];
    
}
-(void) addArray:(NSArray *)array{
    
    [self.commentsArray addObjectsFromArray:array];
    [self.tableView reloadData];
    
}



-(void)setCommentsArray:(NSMutableArray *)commentsArray{
    if (commentsArray != nil) {
        _commentsArray = commentsArray;
        [self.tableView reloadData];
    }

}

-(void)initData{
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:NO];
    result.onSuccess = ^(NTGMemberArticleDetail *articleDetail){
        
        self.commentsArray = [NSMutableArray arrayWithArray:articleDetail.memberComments.content] ;
    };
    NSString *string = [NSString stringWithFormat:@"%ld",self.memberArticleId];
    NSDictionary *param = @{@"memberArticleId":string};
    [NTGSendRequest getMemBerArticleDetail:param success:result];
    
    
}

- (IBAction)commentAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGPublishCommentController *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"publisComment"];
    commentsVC.refuresh = ^(){
        [self initData];
    
    };
    commentsVC.memberArticleId = self.memberArticleId;
    [self.navigationController pushViewController:commentsVC animated:YES];

    
    
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.commentsArray.count > 0) {
        NTGMemberComment *comment = self.commentsArray[indexPath.row];
        return comment.cellHeight;
        
    }else{
    
        return CGFLOAT_MIN;
    }



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.commentsArray.count > 0 ? self.commentsArray.count : 1 ;
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.commentsArray.count) {
        NTGArticleCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[NTGArticleCommentsCell alloc] init];
        }
        cell.comment = self.commentsArray[indexPath.row];
        cell.index = indexPath.row;
        cell.cellDelegate = self;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 40)];
        notice.text = @"现在还没有人评论，快去评论吧~~";
        notice.textAlignment = NSTextAlignmentCenter;
        notice.center = cell.contentView.center;
        [cell.contentView addSubview:notice];
        return cell;
    
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)replyComment:(NTGMemberComment *)comment index:(NSInteger)index{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGCommentReplysController *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"commentReply"];
    commentsVC.comment = comment;
    commentsVC.articleID = self.memberArticleId;
    commentsVC.index = index;
    [self.navigationController pushViewController:commentsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
