/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGRujiaPensionController.h"
#import "NTGSendRequest.h"
#import "NTGPensionAgencyTableView.h"
#import "NTGClassCategoryController.h"
#import "NTGConstant.h"

/**
 * control - 如家养老机构
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRujiaPensionController ()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthBtn;

@end

@implementation NTGRujiaPensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"如家养老";
    [self.firstBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (IBAction)clickBtn:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassCategory" bundle:nil];
    NTGClassCategoryController *classCategoryController = [storyboard instantiateViewControllerWithIdentifier:@"classCategoryController"];
    UIButton * ub = (UIButton *) sender;
    NSInteger clickBtnTag =[ub tag];
    NSDictionary *dict = nil;
    if (clickBtnTag == 100) {
        [self.firstBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fifthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dict = @{@"smallTypeOption":@"4",@"_categoryNav_":@"老年公寓"};
    }else if (clickBtnTag == 200){
        [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.secondBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fifthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dict = @{@"smallTypeOption":@"7",@"_categoryNav_":@"养老院"};
    }else if (clickBtnTag == 300){
        [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.thirdBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fifthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dict = @{@"smallTypeOption":@"8",@"_categoryNav_":@"敬老院"};
    }else if (clickBtnTag == 400){
        [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fourthBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.fifthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dict = @{@"smallTypeOption":@"6",@"_categoryNav_":@"托老所"};
    }else if (clickBtnTag == 500){
        [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fifthBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        dict = @{@"smallTypeOption":@"5",@"_categoryNav_":@"护理院"};
    }
    classCategoryController.reqParam = [NSMutableDictionary dictionaryWithDictionary:dict];
    [self.navigationController pushViewController:classCategoryController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/** 请求数据 */
- (void)initData:(NTGPullRefresh)action {
    [NTGSendRequest getRujia:self.reqParam success:^(NSArray *rj) {
        [self updateTableView:rj action:action state:YES];
        //[self.pensionAgencyTableView addSellers:rj];  //.sellers = rj;
    }];
}

@end
