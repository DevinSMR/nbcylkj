/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGBankCardListController.h"
#import "NTGSendRequest.h"
#import "NTGAttribute.h"
#import "NTGAttibuteOption.h"
#import "NTGBankCardCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NTGAlipayAppBean.h"
#import "NTGWechatAppBean.h"
//#import "WXApi.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 信用卡支持列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGBankCardListController ()<UITableViewDataSource>
/** 银行卡列表 */
@property (weak, nonatomic) IBOutlet UITableView *bankCardTable;
/** 模型数据 */
@property (nonatomic,strong) NSArray *bankCards;
@end

@implementation NTGBankCardListController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setBankCards:(NSArray *)bankCards {
    _bankCards = bankCards;
    [self.bankCardTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)zhifubaoPay:(id)sender {
    NSDictionary *dict = @{
                       @"paymentPluginId":@"aliPayAppPlugin",
                           @"type":@"payment",
                           @"sn":self.sn,
                           @"amount":@"0"
                           };
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSString *paymentSn) {
        NTGBusinessResult *invokePayResult = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        
        invokePayResult.onSuccess = ^(NTGAlipayAppBean *alipayAppBean) {
            NSString *appScheme = @"alisdkjoin";
            [[AlipaySDK defaultService] payOrder:alipayAppBean.parameterMap fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
                if ([[resultDic valueForKey:@"resultStatus"] isEqualToString:@"6001"]) {
                    
                    [NTGMBProgressHUD alertView:@"您已取消付款" view:self.view];
                }else if ([[resultDic valueForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                    [NTGMBProgressHUD alertView:@"订单支付成功" view:self.view];
                    
                }else if ([[resultDic valueForKey:@"resultStatus"] isEqualToString:@"8000"]) {
                    [NTGMBProgressHUD alertView:@"正在处理中" view:self.view];
                    
                }else if ([[resultDic valueForKey:@"resultStatus"] isEqualToString:@"4000"]) {
                    [NTGMBProgressHUD alertView:@"订单支付失败" view:self.view];
                    
                }else if ([[resultDic valueForKey:@"resultStatus"] isEqualToString:@"6002"]) {
                    [NTGMBProgressHUD alertView:@"网络连接出错" view:self.view];
                    
                }
                
            }];
        };
        NSDictionary *dict = @{
                               @"paymentGroupSn":paymentSn,
                               };
        [NTGSendRequest aliPay:dict success:invokePayResult];
    };
    [NTGSendRequest getPaymentGroup:dict success:result];
    
}


#pragma mark - WXApiDelegate
//- (void)onResp:(BaseResp *)resp {
//    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.mode = MBProgressHUDModeText;
//    HUD.labelText = @"网络连接出错";
//    HUD.margin = 10.f;
//    HUD.yOffset = 150.f;
//    [HUD hide:YES afterDelay:3];
    
//}

- (IBAction)weixinPay:(id)sender {
    
    //BOOL b = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alisdkjoi1222n:"]];
    
    NSDictionary *dict = @{
                           @"paymentPluginId":@"aliPayAppPlugin",
                           @"type":@"payment",
                           @"sn":self.sn,
                           @"amount":@"0"
                           };
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSString *paymentSn) {
        
        
        NTGBusinessResult *invokePayResult = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        
        invokePayResult.onSuccess = ^(NTGWechatAppBean *alipayAppBean) {
           
//            // 发起微信
//            PayReq *request = [[PayReq alloc]init];
//            
//            request.partnerId = alipayAppBean.partnerid;// 商品号
//            request.prepayId = alipayAppBean.prepayid;// 预支付交易会话ID
//            request.package = alipayAppBean.packageValue;// 获取包裹
//            request.nonceStr = alipayAppBean.noncestr;// 获取随机字符串
//            request.timeStamp = (UInt32)alipayAppBean.timestamp;// 获取时间戳
//            request.sign = alipayAppBean.sign;// 签名
//            [WXApi sendReq:request];
        };
        
        NSDictionary *dict = @{
                               @"paymentGroupSn":paymentSn,
                               };
        [NTGSendRequest wechatPay:dict success:invokePayResult];
    };
    [NTGSendRequest getPaymentGroup:dict success:result];
 
}

-(void)initData {
    NSDictionary *dict = @{@"paymentPluginId":@"yeepayPartnerPlugin"};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NSArray *attributes) {
        if (attributes.count>=2) {
            NTGAttribute *atts= attributes[1];
            self.bankCards = atts.option;
//            for (int i=0; self.bankCards.count; <#increment#>) {
//                <#statements#>
//            }
//            NTGAttibuteOption *attibuteOption = atts.option;
        }
    };
    [NTGSendRequest getBankCardList:dict success:result];
}

#pragma 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankCards.count;
}

- (NTGBankCardCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTGBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.attibuteOption = self.bankCards[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
