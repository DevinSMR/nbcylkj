/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRoomDetailController.h"
#import "NTGElderlyEstateContent.h"
#import "EQPageCycleSize.h"
#import <UIImageView+WebCache.h>

/**
 * control - 地产详情描述
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRoomDetailController ()
/** 房产概述 */
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
/** 周边配套图片 */
@property (weak, nonatomic) IBOutlet UIView *iconProjectImg;
/** 周边配套介绍 */
@property (weak, nonatomic) IBOutlet UILabel *lblProjectText;
/** 周边环境图片 */
@property (weak, nonatomic) IBOutlet UIView *iconFacility;
/** 周边环境介绍 */
@property (weak, nonatomic) IBOutlet UILabel *lblFacilityText;
/** 公交路线 */
@property (weak, nonatomic) IBOutlet UILabel *lblBusLine;
/** 自驾路线 */
@property (weak, nonatomic) IBOutlet UILabel *lblDrivingLine;
@property (nonatomic,assign) int tag;

@end

@implementation NTGRoomDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self addImageViews];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<p>\r\n\t\\.<span style=\"font-size:16px:m����, Vredana, Arial;line-height:16px;background-color:#FFFFFF;\">&nbsp; &nbsp;\\/"];
    NSString *introduction = self.project.introduction;
    introduction = [[introduction componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.lblIntro.text = introduction;
    NSString *aroundIntroduction = self.project.introduction;
    aroundIntroduction = [[aroundIntroduction componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.lblProjectText.text = aroundIntroduction;
    NSString *facilityIntroduction = self.project.introduction;
    facilityIntroduction = [[facilityIntroduction componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.lblFacilityText.text = facilityIntroduction;
    NSString *busLine = self.project.introduction;
    busLine = [[busLine componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.lblBusLine.text = busLine;
    NSString *drivingLine = self.project.introduction;
    drivingLine = [[drivingLine componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.lblDrivingLine.text = drivingLine;
}

/** 添加图片 */
- (void)addImageViews {
    CGFloat iconW = 130 ;
    CGFloat iconH = 70;
    CGFloat iconY = 0;
    UIScrollView *aroundScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iconY, UI_CURRENT_SCREEN_WIDTH-25, iconH)];
    UIImageView *aroundIocnView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconY, iconW, iconH)];
    if (self.project.aroundIntroductionImage1) {
        [aroundIocnView1 sd_setImageWithURL:[NSURL URLWithString:self.project.aroundIntroductionImage1]];
    }else {
        aroundIocnView1.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *aroundIocnView2 = [[UIImageView alloc]initWithFrame:CGRectMake(iconW+2, iconY, iconW, iconH)];
    if (self.project.aroundIntroductionImage2) {
        [aroundIocnView2 sd_setImageWithURL:[NSURL URLWithString:self.project.aroundIntroductionImage2]];
    }else {
        aroundIocnView2.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *aroundIocnView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*(iconW+2), iconY, iconW, iconH)];
    if (self.project.aroundIntroductionImage3) {
        [aroundIocnView3 sd_setImageWithURL:[NSURL URLWithString:self.project.aroundIntroductionImage3]];
    }else {
        aroundIocnView3.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *aroundIocnView4 = [[UIImageView alloc]initWithFrame:CGRectMake(3*(iconW+2), iconY, iconW, iconH)];
    if (self.project.aroundIntroductionImage4) {
        [aroundIocnView4 sd_setImageWithURL:[NSURL URLWithString:self.project.aroundIntroductionImage4]];
    }else {
        aroundIocnView4.image = [UIImage imageNamed:@"icon72"];
    }
    [aroundScollView addSubview:aroundIocnView1];
    [aroundScollView addSubview:aroundIocnView2];
    [aroundScollView addSubview:aroundIocnView3];
    [aroundScollView addSubview:aroundIocnView4];
    aroundScollView.showsHorizontalScrollIndicator = NO;
    aroundScollView.bounces = NO;
    aroundScollView.contentSize = CGSizeMake(4*(iconW+2), 0);
    [self.iconProjectImg addSubview:aroundScollView];
    
    UIScrollView *facilityScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iconY, UI_CURRENT_SCREEN_WIDTH-25, iconH)];
    UIImageView *facilityIocnView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, iconY, iconW, iconH)];
    if (self.project.facilityImage1) {
        [facilityIocnView1 sd_setImageWithURL:[NSURL URLWithString:self.project.facilityImage1]];
    }else {
        facilityIocnView1.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *facilityIocnView2 = [[UIImageView alloc]initWithFrame:CGRectMake(iconW+2, iconY, iconW, iconH)];
    if (self.project.facilityImage2) {
        [facilityIocnView2 sd_setImageWithURL:[NSURL URLWithString:self.project.facilityImage2]];
    }else {
        facilityIocnView2.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *facilityIocnView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*(iconW+2), iconY, iconW, iconH)];
    if (self.project.facilityImage3) {
        [facilityIocnView3 sd_setImageWithURL:[NSURL URLWithString:self.project.facilityImage3]];
    }else {
        facilityIocnView3.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *facilityIocnView4 = [[UIImageView alloc]initWithFrame:CGRectMake(3*(iconW+2), iconY, iconW, iconH)];
    if (self.project.facilityImage4) {
        [facilityIocnView4 sd_setImageWithURL:[NSURL URLWithString:self.project.facilityImage4]];
    }else {
        facilityIocnView4.image = [UIImage imageNamed:@"icon72"];
    }
    UIImageView *facilityIocnView5 = [[UIImageView alloc]initWithFrame:CGRectMake(4*(iconW+2), iconY, iconW, iconH)];
    if (self.project.facilityImage5) {
        [facilityIocnView5 sd_setImageWithURL:[NSURL URLWithString:self.project.facilityImage5]];
    }else {
        facilityIocnView5.image = [UIImage imageNamed:@"icon72"];
    }
    [facilityScollView addSubview:facilityIocnView1];
    [facilityScollView addSubview:facilityIocnView2];
    [facilityScollView addSubview:facilityIocnView3];
    [facilityScollView addSubview:facilityIocnView4];
    [facilityScollView addSubview:facilityIocnView5];
    facilityScollView.showsHorizontalScrollIndicator = NO;
    facilityScollView.bounces = NO;
    facilityScollView.contentSize = CGSizeMake(5*(iconW+2), 0);
    [self.iconFacility addSubview:facilityScollView];
}

/** 房产概述查看更多 */
- (IBAction)moreIntroBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.tag = self.tag;
    if(btn.tag == 0) {
        self.lblIntro.numberOfLines = 0;
        btn.tag = 1;
        self.tag = (int)btn.tag;
    }else {
        self.lblIntro.numberOfLines = 4;
        btn.tag = 0;
        self.tag = (int)btn.tag;
    }
}

/** 周边配套查看更多 */
- (IBAction)moreProjectBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.tag = self.tag;
    if(btn.tag == 0) {
        self.lblProjectText.numberOfLines = 0;
//        self.lblProjectText.font = [UIFont systemFontOfSize:14];
        btn.tag = 1;
        self.tag = (int)btn.tag;
    }else {
        self.lblProjectText.numberOfLines = 4;
        btn.tag = 0;
//        self.lblProjectText.font = [UIFont systemFontOfSize:12];
        self.tag = (int)btn.tag;
    }
}

/** 周边环境查看更多 */
- (IBAction)moreFacilityBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.tag = self.tag;
    if(btn.tag == 0) {
        self.lblFacilityText.numberOfLines = 0;
//        self.lblFacilityText.font = [UIFont systemFontOfSize:14];
        btn.tag = 1;
        self.tag = (int)btn.tag;
    }else {
        self.lblFacilityText.numberOfLines = 4;
        btn.tag = 0;
//        self.lblFacilityText.font = [UIFont systemFontOfSize:12];
        self.tag = (int)btn.tag;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
