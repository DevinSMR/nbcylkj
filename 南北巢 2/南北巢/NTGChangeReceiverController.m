/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGChangeReceiverController.h"
#import "NTGSendRequest.h"
#import "NTGAreaPikerView.h"
#import "EQPageCycleSize.h"
#import "NTGArea.h"
#import "NTGSendRequest.h"
#import "NTGMBProgressHUD.h"
#import "NTGReceiverContent.h"
#import "NTGValidateMobile.h"
#import "NSString+Emoji.h"

/**
 * control - 新增、编辑收货地址
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGChangeReceiverController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) NTGAreaPikerView *areaPikerView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UITextField *textName;
/** 电话 */
@property (weak, nonatomic) IBOutlet UITextField *textphoneNum;
/** 所在区域 */
@property (weak, nonatomic) IBOutlet UILabel *areaName;
/** 街道 */
@property (weak, nonatomic) IBOutlet UITextField *textStreet;
/** 邮编 */
@property (weak, nonatomic) IBOutlet UITextField *textZipCode;
/** 石头默认 */
@property (weak, nonatomic) IBOutlet UIButton *isDefaultBtn;
/** 保存按钮 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic,strong) NTGArea* currentSelectArea;
/** 编辑删除 */
@property (weak, nonatomic) IBOutlet UIButton *editDelete;
/** 编辑保存 */
@property (weak, nonatomic) IBOutlet UIButton *editSave;
/** 区域按钮 */
@property (weak, nonatomic) IBOutlet UIButton *areaSelectBtn;

@end
//进入页面时将所有地区的值存放到这个数组里面
static NSArray *_cacheAreas = nil;
@implementation NTGChangeReceiverController

/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    self.editDelete.hidden = !self.receiverId;
    self.editSave.hidden = !self.receiverId;
    self.saveBtn.hidden = [self.receiverId intValue];
    if (self.receiverId) { //编辑
        self.lblTitle.text = @"编辑地址";
        self.editSave.enabled = NO;
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(NTGReceiverContent *receiverContent) {
//            self.receiverContent = receiverContent;
            self.currentSelectArea = receiverContent.area;
            self.textStreet.text = receiverContent.address;
            self.textName.text = receiverContent.consignee;
            self.textphoneNum.text = receiverContent.phone;
            self.textZipCode.text = receiverContent.zipCode;
            self.areaName.text = self.currentSelectArea.fullName;
            self.isDefaultBtn.selected = receiverContent.isDefault;
            self.editSave.enabled = YES;
        };
        NSDictionary *dict = @{
                               @"id":self.receiverId
                              };
        [NTGSendRequest getReceiver:dict success:result];
        
    }else {
        self.lblTitle.text = @"新增地址";
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self areaList];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 设置默认收货地址 */
- (IBAction)setIsDefault:(id)sender {
    _isDefaultBtn.selected = !_isDefaultBtn.selected;
}

/** 检查收货人资料信息完整度 */
- (BOOL)checkFinish {
    BOOL finish = YES;
    if ([NSString stringWithFormat:@"%ld",self.currentSelectArea.id].length == 0 ||
        self.textStreet.text.length==0 ||
        self.textName.text.length==0 ||
        self.textZipCode.text.length==0 ||
        self.textphoneNum.text.length==0 ||
        [NSString stringWithFormat:@"%d",self.isDefaultBtn.selected].length==0 ) {
        [NTGMBProgressHUD alertView:@"亲，资料不完整哦!" view:self.view];
        return NO;
    }
    
    return finish;
}

/** 保存收货地址 */
- (IBAction)saveReceiver:(id)sender {
    if (![self checkFinish]) {
        return;
    }
    if([NSString isContainsEmoji:self.textName.text]) {
        [NTGMBProgressHUD alertView:@"请输入不带表情的文字、字母或数字" view:self.view];
        return ;
    }
    if (![NTGValidateMobile validateMobile:self.textphoneNum.text]) {
        [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
        return;
    }
    
    if (self.textZipCode.text.length<1 || self.textZipCode.text.length>6) {
        [NTGMBProgressHUD alertView:@"请输入正确的邮编" view:self.view];
        return;
    }
    if (self.currentSelectArea.id == 0) {
        [NTGMBProgressHUD alertView:@"请选择所在地区" view:self.view];
        return;
    }
    NSDictionary *dict = @{
                           @"areaId":[NSString stringWithFormat:@"%ld",self.currentSelectArea.id],
                           @"address":self.textStreet.text,
                           @"consignee":self.textName.text,
                           @"phone":self.textphoneNum.text,
                           @"zipCode":self.textZipCode.text,
                           @"isDefault":[NSString stringWithFormat:@"%d",self.isDefaultBtn.selected]
                           };
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest saveReceiver:dict success:result];
    
}
/** 编辑删除 */
- (IBAction)editDeleteBtn:(id)sender {
    
    NSDictionary *dict = @{@"id":self.receiverId};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id areas) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest deleteReceiver:dict success:result];
}

/** 编辑保存 */
- (IBAction)editSaveBtn:(id)sender {
    
    if (![self checkFinish]) {
        return;
    }
    if([NSString isContainsEmoji:self.textName.text]) {
        [NTGMBProgressHUD alertView:@"请输入不带表情的文字、字母或数字" view:self.view];
        return ;
    }
    if (![NTGValidateMobile validateMobile:self.textphoneNum.text]) {
        [NTGMBProgressHUD alertView:@"请输入正确的手机号" view:self.view];
        return;
    }
    if (self.textZipCode.text.length<1 || self.textZipCode.text.length>6) {
        [NTGMBProgressHUD alertView:@"请输入正确的邮编" view:self.view];
        return;
    }
    if (self.currentSelectArea.id == 0) {
        [NTGMBProgressHUD alertView:@"请选择所在地区" view:self.view];
        return;
    }

    NSDictionary *dict = @{
                           @"id":self.receiverId,
                           @"areaId":[NSString stringWithFormat:@"%ld",self.currentSelectArea.id],
                           @"address":self.textStreet.text,
                           @"consignee":self.textName.text,
                           @"phone":self.textphoneNum.text,
                           @"zipCode":self.textZipCode.text,
                           @"isDefault":[NSString stringWithFormat:@"%d",self.isDefaultBtn.selected]
                           };
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest editReceiver:dict success:result];
}

/** 选择区域 */
- (IBAction)chooseArea:(id)sender {
    self.areaPikerView = [NTGAreaPikerView viewWithView];
    self.areaPikerView.frame = CGRectMake(0, 400, UI_CURRENT_SCREEN_WIDTH, UI_SCREEN_HEIGHT-400);
    [self.areaPikerView.doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    self.areaPikerView.areaPiker.dataSource = self;
    self.areaPikerView.areaPiker.delegate = self;
    [self.view addSubview:self.areaPikerView];
    
    [NTGAreaPikerView beginAnimations:nil context:nil];
    [NTGAreaPikerView setAnimationDuration:2];
    [NTGAreaPikerView commitAnimations];
    self.areaSelectBtn.enabled = NO;
    //如果
    if (_cacheAreas == nil || _cacheAreas.count < 1) {
        [self areaList];
    }else{
         //选中值
        [self.areaPikerView.areaPiker reloadAllComponents];
        [self setPickViewSelectWithCurrentArea:self.currentSelectArea];
    }
}

/** 获取地区列表 */
- (void) areaList {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id areas) {
        _cacheAreas = areas;
        [self.areaPikerView.areaPiker reloadAllComponents];
        [self setPickViewSelectWithCurrentArea:self.currentSelectArea];
        //选中值
    };
    [NTGSendRequest getAreaList:nil success:result];

}

/** 给pikerview设置初始值 */
- (void) setPickViewSelectWithCurrentArea:(NTGArea *)currentArea {
    //allparentStr
    NSString *allparentStr = currentArea.treePath;
    
    allparentStr = [allparentStr substringWithRange:NSMakeRange(1, allparentStr.length-2)];
    //把字符串拆分成数组
    NSArray * allparents = [allparentStr componentsSeparatedByString:@","]; //[allparentStr
    
    //split];
    NSMutableArray * allAreas = [NSMutableArray arrayWithArray:allparents];
    
    [allAreas addObject:[NSString stringWithFormat:@"%ld", currentArea.id]];
    for (int i = 0 ; i< allAreas.count; i++) {
        //i 为pickview的COMPNENT
        //找行allparents[i] , i
        NSString *areaId = allAreas[i];
//        NSArray *areas = [self areasForComponent:self.areaPikerView.areaPiker component:i];
        long row = [self getAreaIndexWithAreaId:[areaId intValue] areas:_cacheAreas];
        [self.areaPikerView.areaPiker reloadComponent:i];
        [self.areaPikerView.areaPiker selectRow:row inComponent:i animated:YES];
        //[self.areaPikerView.areaPiker reloadAllComponents];
        
    }
}

/** 查找行号 */
//此处相当于多层for循环嵌套
- (long)getAreaIndexWithAreaId:(long)areaid areas:(NSArray *)areas{
    
    for (int i = 0; i < areas.count; i++) {
        NTGArea *area = areas[i];
        if (area.id == areaid) {
            return i;
        }
        NSArray *child =  area.children;
        long temp = [self getAreaIndexWithAreaId:areaid areas:child];
        if (temp != -1) {
           return temp;
        }
    }
    return -1;
}

/** 查找pickview中选中的最后一个区域*/
- (NTGArea *) getLastSelectArea{
    NSArray *preArea = _cacheAreas;
    NTGArea *cArea  = nil;
    for (int i = 0; i < self.areaPikerView.areaPiker.numberOfComponents; i++) {
        NSInteger preIndex =[self.areaPikerView.areaPiker selectedRowInComponent:i];
        if (preArea.count == 0 //没有元素
            ||preIndex == -1 //没有选中
            ||preIndex > (preArea.count - 1)
            ) {
            break;
        }
        cArea = preArea[preIndex];
        preArea = cArea.children;
    }
    return cArea;
}

/** 完成 */
- (void)doneClick {
    self.currentSelectArea = [self getLastSelectArea];
    self.areaName.text = self.currentSelectArea.fullName;
    [self.areaPikerView removeFromSuperview];
    [NTGAreaPikerView beginAnimations:nil context:nil];
    [NTGAreaPikerView setAnimationDuration:2];
    [NTGAreaPikerView commitAnimations];
    self.areaSelectBtn.enabled = YES;
}

/** 获取选中的选择区域 */
- (NSArray*)areasForComponent:(UIPickerView*)pickerView component:(NSInteger)component {
    NSArray *preArea = _cacheAreas;
    for (int i = 0; i < component; i++) {
        NSInteger preIndex =[pickerView selectedRowInComponent:i];
        if(preIndex >= preArea.count) {
            preIndex = preArea.count - 1;
        }
        NTGArea *area = preArea[preIndex];
        preArea = area.children;
    }
    return preArea;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *areas = [self areasForComponent:pickerView component:component];
    return areas.count;
}


#pragma mark - 代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *componentData = [self areasForComponent:pickerView component:component];
    NSString *name = @"";
    if(row < componentData.count) {
        name = ((NTGArea *)componentData[row]).name;
    }
//    NSLog(@"name:%@,%ld,%ld",name,row,component);
    return name;
    //NSMutableString *attriString = [[NSMutableString alloc]initWithString:name];
    //return attriString;

}

/** pikerView选中后执行 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//    NSLog(@"didSelectRow : %ld",row);
    for (int i = ((int)component + 1); i < pickerView.numberOfComponents; i++) {
        [pickerView reloadComponent:i];
    }
    //选中行
    //[pickerView selectRow:1 inComponent:component animated:YES];
    
    
}

/** 行高 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
