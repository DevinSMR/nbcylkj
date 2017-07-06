/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMyFavoriteListController.h"
#import "NTGproductCell.h"
#import "NTGSendRequest.h"
#import "NTGPage.h"
#import "NTGProductContent.h"
#import "NTGMBProgressHUD.h"
#import "NTGProductDetailController.h"

/**
 * control - 我的收藏
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMyFavoriteListController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
/** 收藏列表 */
@property (weak, nonatomic) IBOutlet UITableView *favoriteTable;
/** 编辑按钮 */
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic,strong) NSArray *sellers;
@property (nonatomic,strong) NSMutableArray *productIds;
@end

@implementation NTGMyFavoriteListController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setSellers:(NSArray *)sellers {
    _sellers = sellers;
    [self.favoriteTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"我的收藏";
    self.favoriteTable.dataSource = self;
    self.favoriteTable.delegate = self;
    self.favoriteTable.rowHeight = 90;
    [self initData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page) {
        self.sellers = page.content;
        if (page.content.count == 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            self.favoriteTable.tableFooterView = view;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            label.text = @"亲，还没有收藏，赶紧去收藏吧！";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    };
    [NTGSendRequest favoriteList:nil success:result];
}

- (IBAction)editBtn:(id)sender {
    if ([self.editBtn.titleLabel.text isEqualToString:@"删除"]) {
        NSString * selectProductIds = [self getAllSelectProductIds];
        if (selectProductIds.length>0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除收藏的商品吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alertView show];
            
        }else {
            [NTGMBProgressHUD alertView:@"请选择要删除的商品" view:self.view];
        }
    }
    if ([self.editBtn.titleLabel.text isEqualToString:@"编辑"]) {
        [self.editBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self initData];
    }
    if ([self.editBtn.titleLabel.text isEqualToString:@"完成"]) {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self initData];
    }
}

#pragma 数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGProductCell *cell = nil;
    if ([self.editBtn.titleLabel.text isEqualToString:@"编辑"] ) {
        cell = [NTGProductCell cellWithTableView:tableView reuseID:@"ProductCell" nibNamed:@"NTGProductCell"];
       if (cell == nil) {
            cell = [[NTGProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
       }
    }
    if ([self.editBtn.titleLabel.text isEqualToString:@"删除"]|| [self.editBtn.titleLabel.text isEqualToString:@"完成"]) {
        cell = [NTGProductCell cellWithTableView:tableView reuseID:@"favoriteCell" nibNamed:@"NTGFavoriteList"];
        if (cell == nil) {
            cell = [[NTGProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"favoriteCell"];
         }
    }
    cell.productContent = self.sellers[indexPath.row];
    if (cell.productContent.flag == NO) {
        cell.selectBtn.selected = NO;
    }
    [cell.selectBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGProductDetail" bundle:nil];
    NTGProductDetailController *productDetailController = [storyboard instantiateInitialViewController];
    productDetailController.product = self.sellers[indexPath.row];
    [self.navigationController pushViewController:productDetailController animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString * selectProductIds = [self getAllSelectProductIds];
    if (buttonIndex == 1) {

        NSDictionary *dict = @{@"productId":selectProductIds};

        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            
            [self initData];
            [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        };
        [NTGSendRequest favoriteDelete:dict success:result];
    }
}
//编辑状态下的选择按钮事件
- (void)selectBtn:(UIButton *)btn {
    btn.selected = !btn.selected;
    NTGProductCell *cell = (NTGProductCell *)btn.superview.superview;
    NTGProductContent *productContent = cell.productContent;
    productContent.flag = btn.selected;
}

/** 获取选中的商品的ID */
- (NSString *)getAllSelectProductIds {
    NSString *cid = @"";
    self.productIds = [NSMutableArray array];
    for (int j = 0; j < self.sellers.count; j++) {
        NTGProductContent *productContent = self.sellers[j];
        if (productContent.flag) {
            cid = [cid stringByAppendingString:[NSString stringWithFormat:@"%ld", productContent.id]];
            [self.productIds addObject:cid];
            cid = [cid stringByAppendingString:@","];
        }
    }
    return cid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
