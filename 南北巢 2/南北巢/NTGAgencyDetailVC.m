
//
//  NTGAgencyDetailVC.m
//  南北巢
//
//  Created by nbc on 17/7/5.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGAgencyDetailVC.h"
#import "NTGAgenyDetailCell.h"
#import "NTGAgenyDetailStringCell.h"
#import "EQPageCycleSize.h"
#import <UIImageView+WebCache.h>
#import "UILabel+StringFrame.h"
@interface NTGAgencyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NTGAgencyDetailVC
- (IBAction)backToAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:@"NTGAgenyDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self.table registerNib:[UINib nibWithNibName:@"NTGAgenyDetailStringCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"stringCell"];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.introduction] size:CGSizeMake(self.view.bounds.size.width - 23, 0)];
            return 60 + size.height;
        
        }
            break;
        case 1:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.institution.aroundIntroduction ] size:CGSizeMake(self.view.bounds.size.width - 23, 0)];

            return 130 + size.height;
            
        }
            break;
        case 2:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.institution.institutionFacilityDesc ]  size:CGSizeMake(self.view.bounds.size.width - 23, 0)];

            return 130 + size.height;
            
        }
            break;
        case 3:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.institution.institutionService ]  size:CGSizeMake(self.view.bounds.size.width - 23, 0)];

            return 130 + size.height;
            
        }
            break;
        case 4:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.institution.institutionBus ]  size:CGSizeMake(self.view.bounds.size.width - 23, 0)];

            return 60 + size.height;
            
        }
            break;
        case 5:
        {
            CGSize size = [self boundingRectWithStr:[self deleteSpecialChart:self.seller.institution.institutionDriving ]  size:CGSizeMake(self.view.bounds.size.width - 23, 0)];

            return 60 + size.height;
            
        }
            break;
            
        default:
            break;
    }

    return CGFLOAT_MIN;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
    switch (indexPath.row) {
        case 0:{
        
            NTGAgenyDetailStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stringCell" forIndexPath:indexPath];
            
            cell.titleLb.text = @"机构详情";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.introduction];
             
            return cell;
        }
            break;
        case 1:{
            NTGAgenyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.titleLb.text = @"周边设施";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.institution.aroundIntroduction];
            [cell.iconView addSubview:[self aroundImgeView]];
            return cell;
        }

            break;
        case 2:{
            NTGAgenyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.titleLb.text = @"机构设施";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.institution.institutionFacilityDesc];
            NSLog(@"%@",[self deleteSpecialChart:self.seller.institution.institutionFacilityDesc]);
            [cell.iconView addSubview:[self facilityIocnView]];
            return cell;

        }
            break;
        case 3:
        {
            NTGAgenyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.titleLb.text = @"机构服务";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.institution.institutionService];
            [cell.iconView addSubview:[self serviceScollView]];
            return cell;

        }
           break;
        case 4:{
            NTGAgenyDetailStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stringCell" forIndexPath:indexPath];
            
            cell.titleLb.text = @"公交线路";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.institution.institutionBus];
            return cell;

        }
           break;
        case 5:{
            NTGAgenyDetailStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stringCell" forIndexPath:indexPath];
            
            cell.titleLb.text = @"自驾线路";
            
            cell.contentLb.text = [self deleteSpecialChart:self.seller.institution.institutionDriving];
            return cell;
        }
          break;

        default:
            break;
    }

    return nil;

}
-(UIScrollView *)aroundImgeView{
    CGFloat iconW = 130 ;
    CGFloat iconH = 70;
    CGFloat iconY = 0;
    UIScrollView *aroundScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iconY, UI_CURRENT_SCREEN_WIDTH-25, iconH)];
    UIImageView *aroundIocnView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconY, iconW, iconH)];
    
    [aroundIocnView1 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.aroundIntroductionImage1] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *aroundIocnView2 = [[UIImageView alloc]initWithFrame:CGRectMake(iconW+2, iconY, iconW, iconH)];
    
    [aroundIocnView2 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.aroundIntroductionImage2] placeholderImage:[UIImage imageNamed:@"icon72"]];
    UIImageView *aroundIocnView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*(iconW+2), iconY, iconW, iconH)];
    
    [aroundIocnView3 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.aroundIntroductionImage3] placeholderImage:[UIImage imageNamed:@"icon72"]];
    aroundIocnView3.image = [UIImage imageNamed:@"icon72"];
    
    UIImageView *aroundIocnView4 = [[UIImageView alloc]initWithFrame:CGRectMake(3*(iconW+2), iconY, iconW, iconH)];
    
    [aroundIocnView4 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.aroundIntroductionImage4] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    [aroundScollView addSubview:aroundIocnView1];
    [aroundScollView addSubview:aroundIocnView2];
    [aroundScollView addSubview:aroundIocnView3];
    [aroundScollView addSubview:aroundIocnView4];
    aroundScollView.showsHorizontalScrollIndicator = NO;
    aroundScollView.bounces = NO;
    aroundScollView.contentSize = CGSizeMake(4*(iconW+2), 0);
    return aroundScollView;
}

-(UIScrollView *)facilityIocnView{
    CGFloat iconW = 130 ;
    CGFloat iconH = 70;
    CGFloat iconY = 0;
    UIScrollView *facilityScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iconY, UI_CURRENT_SCREEN_WIDTH-25, iconH)];
    UIImageView *facilityIocnView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconY, iconW, iconH)];
    
    [facilityIocnView1 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionFacilityImage1] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *facilityIocnView2 = [[UIImageView alloc]initWithFrame:CGRectMake(iconW+2, iconY, iconW, iconH)];
    [facilityIocnView2 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionFacilityImage2] placeholderImage:[UIImage imageNamed:@"icon72"]];
    UIImageView *facilityIocnView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*(iconW+2), iconY, iconW, iconH)];
    
    [facilityIocnView3 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionFacilityImage3] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *facilityIocnView4 = [[UIImageView alloc]initWithFrame:CGRectMake(3*(iconW+2), iconY, iconW, iconH)];
    [facilityIocnView4 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionFacilityImage4] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *facilityIocnView5 = [[UIImageView alloc]initWithFrame:CGRectMake(4*(iconW+2), iconY, iconW, iconH)];
    [facilityIocnView5 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionFacilityImage5] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    [facilityScollView addSubview:facilityIocnView1];
    [facilityScollView addSubview:facilityIocnView2];
    [facilityScollView addSubview:facilityIocnView3];
    [facilityScollView addSubview:facilityIocnView4];
    [facilityScollView addSubview:facilityIocnView5];
    facilityScollView.showsHorizontalScrollIndicator = NO;
    facilityScollView.bounces = NO;
    facilityScollView.contentSize = CGSizeMake(5*(iconW+2), 0);
    return facilityScollView;
}

-(UIScrollView *)serviceScollView{
    CGFloat iconW = 130 ;
    CGFloat iconH = 70;
    CGFloat iconY = 0;
    UIScrollView *serviceScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iconY, UI_CURRENT_SCREEN_WIDTH-25, iconH)];
    UIImageView *serviceIocnView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconY, iconW, iconH)];
    
    [serviceIocnView1 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionServiceImage1] placeholderImage:[UIImage imageNamed:@"icon72"]];
    UIImageView *serviceIocnView2 = [[UIImageView alloc]initWithFrame:CGRectMake(iconW+2, iconY, iconW, iconH)];
    
    [serviceIocnView2 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionServiceImage2] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *serviceIocnView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*(iconW+2), iconY, iconW, iconH)];
    
    [serviceIocnView3 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionServiceImage3] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    UIImageView *serviceIocnView4 = [[UIImageView alloc]initWithFrame:CGRectMake(3*(iconW+2), iconY, iconW, iconH)];
    
    [serviceIocnView4 sd_setImageWithURL:[NSURL URLWithString:self.seller.institution.institutionServiceImage4] placeholderImage:[UIImage imageNamed:@"icon72"]];
    
    [serviceScollView addSubview:serviceIocnView1];
    [serviceScollView addSubview:serviceIocnView2];
    [serviceScollView addSubview:serviceIocnView3];
    [serviceScollView addSubview:serviceIocnView4];
    serviceScollView.showsHorizontalScrollIndicator = NO;
    serviceScollView.bounces = NO;
    serviceScollView.contentSize = CGSizeMake(4*(iconW+2), 0);
    return serviceScollView;
}


-(NSString *)deleteSpecialChart:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<p>\r\n\t\\.<span style=\"font-size:16px:m����, Vredana, Arial;line-height:16px;background-color:#FFFFFF;\">&nbsp; &nbsp;\\/"];
    return [[str componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];

}

- (CGSize)boundingRectWithStr:(NSString *)str size:(CGSize)size;
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont  systemFontOfSize:14]};
    
    CGSize retSize = [str boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
//    CGSize retSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return retSize;
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
