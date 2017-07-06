/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGPhotoalbumListController.h"
#import "NTGPhotoListCell.h"
#import "NTGSendRequest.h"
#import "NTGBusinessResult.h"
#import "NTGPage.h"
#import "NTGMBProgressHUD.h"
#import "NTGManagePhotoController.h"
#import <MJRefresh.h>
#import "NTGConstant.h"
#import "NTGCreatPhotoAlbumController.h"
/**
 * control - 设置
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGPhotoalbumListController ()<UITableViewDelegate,UITableViewDataSource,deletePhotoAlbum,pushToPhotoManagerVC>
@property (weak, nonatomic) IBOutlet UITableView *photoTable;
//相册列表
@property (nonatomic,strong) NSMutableArray *photoalbumArray;

@property (nonatomic,strong) NSMutableDictionary *reqParam;
@end

@implementation NTGPhotoalbumListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的图片";
    self.photoTable.delegate = self;
    self.photoTable.dataSource = self;
   // self.navigationController.navigationBar.translucent = NO;
    self.photoalbumArray = [NSMutableArray array];
    
    [self.photoTable registerNib:[UINib nibWithNibName:@"NTGPhotoListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.reqParam = [NSMutableDictionary dictionary];
    // 下拉刷新
    
    self.photoTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pageInitData:NTGPulRefreshDown];
    }];
    
    // 上拉刷新
    self.photoTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
        [NTGSendRequest getMemberPhotoList:self.reqParam success:result];
    }else {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(NTGPage *page){

            [self updateTableView:page.content action:action state:YES];
        };
        [NTGSendRequest getMemberPhotoList:self.reqParam success:result];
    }
}

- (void) updateTableView:(NSArray *)sellers action:(NTGPullRefresh)action state:(BOOL) state {
    if (action == NTGPulRefreshDown || action == NTGPulRefreshInit) {//表示是下拉刷新、初始化加载
        if (state) {
            [self clearData];
        }
        
        if (action == NTGPulRefreshDown) {
            [self.photoTable.mj_header endRefreshing];
        }
        
    }
    else{//上拉加载
        if (sellers.count == 0) {
            [self.photoTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.photoTable.mj_footer endRefreshing];
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
    
    self.photoalbumArray = [NSMutableArray array];
   // [self.photoTable reloadData];
    
    
}
-(void)addArray:(NSArray *)array{
    
    [self.photoalbumArray addObjectsFromArray:array];
    [self.photoTable reloadData];
    
    
}

-(void)setPhotoalbumArray:(NSMutableArray *)photoalbumArray
{
    if (photoalbumArray != nil) {
        _photoalbumArray = photoalbumArray;
        [self.photoTable reloadData];

    }

}
-(void)initData{
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page){
        self.photoalbumArray = [NSMutableArray arrayWithArray:page.content];
    };
    [NTGSendRequest getMemberPhotoList:nil success:result];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.photoalbumArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NTGPhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath ];
    if (!cell ) {
        cell = [[NTGPhotoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.cellDelegate = self;
    cell.photoAlbum = self.photoalbumArray[indexPath.row];
    
    return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 

//    if (indexPath.row == nil) {
//        <#statements#>
//    }
     NTGMemberPhotoAlbum *member = self.photoalbumArray[indexPath.row];
     return member.cellHeight;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
                NTGManagePhotoController *managerVC = [storyboard instantiateViewControllerWithIdentifier:@"managerPhoto"];
                  managerVC.photoAlbum = self.photoalbumArray[indexPath.row];
                [self.navigationController pushViewController:managerVC animated:YES];
}


-(void)pushToPhotoManager:(NTGMemberPhotoAlbum *)photoAlbum{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGManagePhotoController *managerVC = [storyboard instantiateViewControllerWithIdentifier:@"managerPhoto"];
    managerVC.photoAlbum = photoAlbum;
    [self.navigationController pushViewController:managerVC animated:YES];

}

- (IBAction)creatPhotoAlbumAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGCreatPhotoAlbumController *managerVC = [storyboard instantiateViewControllerWithIdentifier:@"creatPhotoAlbum"];
    managerVC.scrollToRow = ^ (){
        NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.photoTable scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    };
    [self.navigationController pushViewController:managerVC animated:YES];
}


-(void)deletePhotoAlum:(long)ID{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"确定删除此相册？" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id object){
            
            [self initData];
        };
        result.onFail = ^(id object){
            
            [NTGMBProgressHUD alertView:@"相册不为空不能删除" view:self.view];
        };
        NSString *AlbumID = [NSString stringWithFormat:@"%ld",ID];
        
        [NTGSendRequest deletePhotoAlbum:@{@"id":AlbumID} success:result];
        
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initData];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
