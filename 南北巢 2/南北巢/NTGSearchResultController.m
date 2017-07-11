//
//  NTGSearchResultController.m
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGSearchResultController.h"
#import <UIImageView+WebCache.h>
#import "NTGProductContent.h"

#import "NTGSeller.h"
@interface NTGSearchResultController ()
@property (weak, nonatomic) IBOutlet UILabel *agencyNum;
@property (weak, nonatomic) IBOutlet UILabel *productNum;
@property (weak, nonatomic) IBOutlet UIImageView *agencyImg1;
@property (weak, nonatomic) IBOutlet UIImageView *agencyImg2;
@property (weak, nonatomic) IBOutlet UILabel *agencyName1;
@property (weak, nonatomic) IBOutlet UILabel *agencyName2;
@property (weak, nonatomic) IBOutlet UILabel *adress1;
@property (weak, nonatomic) IBOutlet UILabel *adress2;
@property (weak, nonatomic) IBOutlet UILabel *agencyPrice1;
@property (weak, nonatomic) IBOutlet UILabel *agencyPrice2;
@property (weak, nonatomic) IBOutlet UIImageView *productImg1;
@property (weak, nonatomic) IBOutlet UIImageView *productImg2;
@property (weak, nonatomic) IBOutlet UILabel *productName1;
@property (weak, nonatomic) IBOutlet UILabel *productName2;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *comment1;
@property (weak, nonatomic) IBOutlet UILabel *comment2;

@end

@implementation NTGSearchResultController
//返回搜索页面
- (IBAction)backToSearchVCAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NTGSeller *seller0 = self.searchResult.institutionPage.content[0];
    NTGSeller *seller1 = self.searchResult.institutionPage.content[1];
    NTGProductContent *product0 = self.searchResult.productPage.content[0];
    NTGProductContent *product1 = self.searchResult.productPage.content[1];
    
    //设置机构和产品的总数
    self.agencyNum.text = [NSString stringWithFormat:@"（%@）",self.searchResult.institutionPage.total];
    self.productNum.text = [NSString stringWithFormat:@"（%@）",self.searchResult.productPage.total];
    
    //设置四张图片
    [self.agencyImg1 sd_setImageWithURL:[NSURL URLWithString:seller0.institution.institutionFocusImage]];
    [self.agencyImg2 sd_setImageWithURL:[NSURL URLWithString:seller1.institution.institutionFocusImage]];
    [self.productImg1 sd_setImageWithURL:[NSURL URLWithString:product0.image]];
    [self.productImg2 sd_setImageWithURL:[NSURL URLWithString:product1.image]];
    
    //设置机构的地址，名字和起始价格
    self.adress1.text = seller0.address;
    self.adress2.text = seller1.address;
    self.agencyName1.text = seller0.name;
    self.agencyName2.text = seller1.name;
    self.agencyPrice1.text = seller0.institution.startPrice;
    self.agencyPrice2.text = seller1.institution.startPrice;
    
    //设置产品的价格，名字和评论数量
    
    self.productName1.text = product0.name;
    self.productName2.text = product1.name;
    self.price1.text = product0.price;
    self.price2.text = product1.price;
//    self.comment1.text = product0.
    
    
    
    
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
