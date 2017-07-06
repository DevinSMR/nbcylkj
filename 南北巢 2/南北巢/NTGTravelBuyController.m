/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */


#import "NTGTravelBuyController.h"
#import <UIImageView+WebCache.h>
#import "NTGTripContent.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
#import "NTGSendRequest.h"
#import "NTGTravelOrderController.h"

/**
 * control - 立即购买
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGTravelBuyController ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 出发日期 */
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
/** 成人减号 */
@property (weak, nonatomic) IBOutlet UIButton *adultMinus;
/** 成人加号 */
@property (weak, nonatomic) IBOutlet UIButton *adultPlus;
/** 儿童减号 */
@property (weak, nonatomic) IBOutlet UIButton *childMinus;
/** 儿童加号 */
@property (weak, nonatomic) IBOutlet UIButton *childPlus;
/** 成人数量 */
@property (weak, nonatomic) IBOutlet UILabel *adultNum;
/** 儿童数量 */
@property (weak, nonatomic) IBOutlet UILabel *childNum;
/** 总价格 */
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (nonatomic,assign) int temp;
@property (nonatomic,assign) int count;
@property (nonatomic,strong) CalendarHomeViewController *chvc;
@end

@implementation NTGTravelBuyController

/** 退出控制器 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"立即预定";
    self.temp = 1;
    self.count = 0;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.trip.product.image]];
    self.lblName.text = self.trip.name;
    [self setBtnBorderColor:self.adultMinus];
    [self setBtnBorderColor:self.adultPlus];
    [self setBtnBorderColor:self.childMinus];
    [self setBtnBorderColor:self.childPlus];
    self.adultNum.layer.borderWidth = 1;
    self.adultNum.layer.borderColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1].CGColor;
    self.childNum.layer.borderWidth = 1;
    self.childNum.layer.borderColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1].CGColor;
//    self.navigationController.navigationBar.tintColor = COLOR_THEME;
    [self departureDate];
    self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.trip.price floatValue]];
}

- (void)initAmount {
    
    NSDictionary *dict = @{
                           @"productId":[NSString stringWithFormat:@"%ld",self.trip.product.id],
                           @"adult":self.adultNum.text,
                           @"children":self.childNum.text,
                           @"date":self.lblDate.text
                           };
    [NTGSendRequest getTripAmount:dict success:^(NSNumber *str) {
        self.lblPrice.text = [NSString stringWithFormat:@"￥%.2f",[str floatValue]];
    }];
}

/** 当前日期 */
- (void)departureDate {
    NSDate * senddate=[NSDate date];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString * nsDateString= [NSString stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)month,(long)day];
    self.lblDate.text = nsDateString;
}

/** 设置按钮边框 */
- (void)setBtnBorderColor:(UIButton *)btn {
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1].CGColor;
}

/** 选取人数 */
- (IBAction)chooseBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        if (self.temp <= 1) {
                [self.adultMinus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
        }else if (self.temp > 1) {
            self.temp--;
            self.adultNum.text = [NSString stringWithFormat:@"%d",self.temp];
                [self.adultMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if ([self.adultNum.text intValue] == 1) {
                [self.adultMinus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        [self initAmount];
    }
    if (btn.tag == 200) {
        self.temp++;
        self.adultNum.text = [NSString stringWithFormat:@"%d",self.temp];
            [self.adultMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self initAmount];
    }
    if (btn.tag == 300) {
        if (self.count <= 1) {
            self.childNum.text = [NSString stringWithFormat:@"0"];
            [self.childMinus setTitleColor:[UIColor colorWithRed:212.0/255 green:212.0/255 blue:213.0/255 alpha:1] forState:UIControlStateNormal];
        }else if (self.count > 1) {
            self.count--;
            self.childNum.text = [NSString stringWithFormat:@"%d",self.count];
                [self.childMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        self.count = [self.childNum.text intValue];
        [self initAmount];
    }
    if (btn.tag == 400) {
        self.count++;
        self.childNum.text = [NSString stringWithFormat:@"%d",self.count];
        [self.childMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self initAmount];
    }
}

/** 选择日期 */
- (IBAction)chooseDate:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (!self.chvc) {
        
        self.chvc = [[CalendarHomeViewController alloc]init];
        
        self.chvc.calendartitle = @"选择出发日期";
//        self.chvc.productId = [NSString stringWithFormat:@"%ld",self.trip.product.id];
        [self.chvc setAirPlaneToDay:365 ToDateforString:nil];
    }
    self.chvc.calendarblock = ^(CalendarDayModel *model){

        if (model.holiday) {
            weakSelf.lblDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initAmount];
        }else{
            weakSelf.lblDate.text = [NSString stringWithFormat:@"%@",[model toString]];
            [weakSelf initAmount];
        }
    };
    
    [self.navigationController pushViewController:self.chvc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"travelOrder"]) {
        NTGTravelOrderController *travelOrderController = segue.destinationViewController;
        travelOrderController.sstartDate = self.lblDate.text;
        travelOrderController.sadultCount = self.adultNum.text;
        travelOrderController.schildCount = self.childNum.text;
        travelOrderController.samount = self.lblPrice.text;
        travelOrderController.trip = self.trip;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
