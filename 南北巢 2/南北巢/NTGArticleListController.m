/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGArticleListController.h"
#import "NTGArticleListCell.h"
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticle.h"
#import "NTGPage.h"
#import "NTGArticleDetailController.h"
#import "CocoaSecurity.h"
#import "NTGPublisAriticleVC.h"
#import "NTGMBProgressHUD.h"
#import "NTGPublisAriticleVC.h"
#import "NTGArticleCommentsController.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
/**
 * control - 我的文章
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGArticleListController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,editArticleDelegate>
//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
//发表/删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//文章列表数组
@property (nonatomic,strong) NSMutableArray *articleListArray;
//被选中文章的ID;
@property (nonatomic,strong) NSMutableArray *articleIDArray;

/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary * reqParam;
@end

@implementation NTGArticleListController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"我的文章";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.estimatedRowHeight = 80.0f;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.reqParam = [NSMutableDictionary dictionary];
    self.articleListArray = [NSMutableArray array];
    [self.deleteBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshUp];
    }];
    
    [self pageInitData:NTGPulRefreshInit];

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
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(NTGPage *page){
            [self updateTableView:page.content action:action state:YES];
        };
        [NTGSendRequest getMemberArticleList:self.reqParam success:result];
    }else {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(NTGPage *page){
            [self updateTableView:page.content action:action state:YES];
        };
        [NTGSendRequest getMemberArticleList:self.reqParam success:result];
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

    self.articleListArray = [NSMutableArray array];
    [self.tableView reloadData];


}
-(void) addArray:(NSArray *)array{
    
   [self.articleListArray addObjectsFromArray:array];
    [self.tableView reloadData];


}


-(void)clickBtn:(UIButton *)button{
    if ([self.deleteBtn.titleLabel.text isEqualToString:@"发表文章"]) {
        UIStoryboard *mineStoryboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
       NTGPublisAriticleVC  *tableVC = [mineStoryboard instantiateViewControllerWithIdentifier:@"article"];
        [self.navigationController pushViewController:tableVC animated:YES];
    }else if ([self.deleteBtn.titleLabel.text isEqualToString:@"删除文章"]) {
        NSString * selectArticleIds = [self getAllSelectArticleIds];
        if (selectArticleIds.length>0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除文章吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alertView show];
            
        }else {
            [NTGMBProgressHUD alertView:@"请选择要删除的文章" view:self.view];
        }
       
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *selectArcticleIds = [self getAllSelectArticleIds];
    if (buttonIndex == 1) {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        NSDictionary *dict = @{@"memberArticleIds":selectArcticleIds};
        result.onSuccess = ^(id responseObject) {
            [self initData];
            [NTGMBProgressHUD alertView:@"删除成功" view:self.view];
            [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [self.deleteBtn setTitle:@"发表文章" forState:UIControlStateNormal];

        };
        [NTGSendRequest deleteArticle:dict success:result];
    }

}
-(void)setArticleListArray:(NSMutableArray *)articleListArray
{
    _articleListArray = articleListArray;
    [self.tableView reloadData];

}


- (IBAction)editBtnAction:(UIButton *)sender {
    if ([self.editBtn.titleLabel.text isEqualToString:@"编辑"]) {
        [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"删除文章" forState:UIControlStateNormal];
        [self initData];
    }
   else if ([self.editBtn.titleLabel.text isEqualToString:@"完成"]){
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"发表文章" forState:UIControlStateNormal];
        [self initData];
    
    }
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData{


    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page){
        self.articleListArray = [NSMutableArray arrayWithArray:page.content];
    };
    [NTGSendRequest getMemberArticleList:nil success:result];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.articleListArray.count;

}

-(NTGArticleListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NTGArticleListCell *cell = nil;
    if ([self.editBtn.titleLabel.text isEqualToString:@"编辑"]) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
    } else if([self.editBtn.titleLabel.text isEqualToString:@"完成"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
       if (cell == nil) {
           cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGSelectArticleCell" owner:nil options:nil]lastObject];
       }
        cell.selectBtn.tag = indexPath.row + 1000;
        cell.bigEditBtn.tag = cell.selectBtn.tag + 2000;
        
        [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //大的选择按钮
        [cell.bigEditBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
 }
    cell.article = self.articleListArray[indexPath.row];
    if (cell.article.tag == NO) {
        cell.selectBtn.selected = NO;
    }
    cell.cellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)showComments:(NTGMemberArticle *)article{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGArticleCommentsController *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"articleComments"];
    commentsVC.memberArticleId = article.id;
    [self.navigationController pushViewController:commentsVC animated:YES];
}

-(void)editArticleDelegate:(NTGMemberArticle *)article{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGPublisAriticleVC *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"article"];
    commentsVC.article = article;
    
    [self.navigationController pushViewController:commentsVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 200;
//}
-(void)selectBtnAction:(UIButton *)btn {
    
        btn.selected = !btn.selected;
        NTGArticleListCell *cell = (NTGArticleListCell *)btn.superview.superview.superview;
        cell.article.tag = btn.selected;
    cell.selectBtn.selected = btn.selected;
   }

/** 获取选中的文章的ID */
- (NSString *)getAllSelectArticleIds {
    NSString *cid = @"";
    self.articleIDArray = [NSMutableArray array];
    for (int j = 0; j < self.articleListArray.count; j++) {
        NTGMemberArticle *article = self.articleListArray[j];
        if (article.tag) {
            cid = [cid stringByAppendingString:[NSString stringWithFormat:@"%ld", article.id]];
            [self.articleIDArray addObject:cid];
            
            cid = [cid stringByAppendingString:@","];
        }
    }
    return cid;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"发表文章"]) {
        
    }
    if ([segue.identifier isEqualToString:@"articleDetail"]) {
        NTGArticleListCell *cell = (NTGArticleListCell *) sender;
        NTGArticleDetailController *detailVC = segue.destinationViewController;
            detailVC.memberArticleId = cell.article.id;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
