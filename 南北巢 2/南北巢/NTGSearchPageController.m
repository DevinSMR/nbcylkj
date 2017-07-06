
//
//  NTGSearchPageController.m
//  南北巢
//
//  Created by nbc on 17/6/28.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGSearchPageController.h"
#import "NTGSearchCell.h"
#import "DBManager.h"
#import "NTGCustomLayout.h"
#import "NTGMBProgressHUD.h"
@interface NTGSearchPageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *historyArray;
@end

@implementation NTGSearchPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSArray *array = [[DBManager shareManager] selectAllSearchHistory];
    _historyArray = [NSMutableArray arrayWithArray:array];
//    _historyArray = [NSMutableArray arrayWithObjects:@"李克强",@"北京",@"里约奥运",@"傅园慧的",@"王宝强烧烤架",@"中国女排",@"傅园慧",@"王宝强烧烤架",@"中国女排",@"傅园慧",@"王宝强烧烤架撒大声地",@"中国女排", nil];
   [self.collectionView reloadData];
    _searchTF.text = nil;
    _searchTF.returnKeyType = UIReturnKeySearch;
   [_searchTF resignFirstResponder];
    _collectionView.collectionViewLayout = [[NTGCustomLayout alloc] init];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

        [_collectionView registerNib:[UINib nibWithNibName:@"NTGSearchCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

}
//取消搜索
- (IBAction)cancleAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//清除历史搜索记录
- (IBAction)cleanSearchHostoryAction:(id)sender {
    [[DBManager shareManager] deleteSearchHistory];
    NSArray *array = [[DBManager shareManager] selectAllSearchHistory];
    _historyArray = [NSMutableArray arrayWithArray:array];
    [self.collectionView reloadData];

}

#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    if (_searchTF.text.length > 0) {
        
        if ([_historyArray indexOfObject:_searchTF.text] == NSNotFound) {
            [[DBManager shareManager] saveSearchHistory:_searchTF.text Success:^(BOOL result) {
                NSLog(@"插入数据成功");
            }];
        }
        NSArray *array = [[DBManager shareManager] selectAllSearchHistory];
        _historyArray = [NSMutableArray arrayWithArray:array];
        [self.collectionView reloadData];
    }else{
        
        [NTGMBProgressHUD alertView:@"请输入搜索内容" view:self.view];
        return YES;
    }
    
    return YES;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.historyArray.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NTGSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.searchStr = _historyArray[indexPath.row];
    return cell;


}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionModel =  self.historyArray[indexPath.row];
    if (sectionModel.length > 0) {
          return [NTGSearchCell getSizeWithText:sectionModel];
    }
    return CGSizeMake(80, 24);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [NTGMBProgressHUD alertView:_historyArray[indexPath.row] view:self.view];
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
