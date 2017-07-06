//
//  NTGAgencyLocation.m
//  南北巢
//
//  Created by nbc on 17/6/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGAgencyLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
@interface NTGAgencyLocation ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    CLGeocoder *_geocoder;

}
@end

@implementation NTGAgencyLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细地址";
    [self initGUI];

}

/** 退出控制器 */
- (void)backBtn:(id)sender {
    [[self navigationController] popViewControllerAnimated:NO];
}

#pragma mark 添加地图控件
-(void)initGUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"xqjg_activity"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    [btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    _geocoder=[[CLGeocoder alloc]init];
    [self getCoordinateByAddress:self.address];


}




#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
        CLLocationCoordinate2D location2= location.coordinate;
        KCAnnotation *annotation2=[[KCAnnotation alloc]init];
        annotation2.title=@"Kenshin&Kaoru";
        annotation2.subtitle=@"Kenshin Cui's Home";
        annotation2.coordinate=location2;
        [_mapView addAnnotation:annotation2];
        
        MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion regions=MKCoordinateRegionMake(annotation2.coordinate, span);
        [_mapView setRegion:regions animated:YES];
        
    }];
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
