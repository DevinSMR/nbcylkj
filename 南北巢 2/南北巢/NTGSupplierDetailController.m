/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSupplierDetailController.h"
#import "NTGSendRequest.h"
#import "NTGSupplier.h"

/**
 * control - 分销商详情
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSupplierDetailController ()
/** 分销商编码 */
@property (weak, nonatomic) IBOutlet UILabel *lblSn;
/** 分销名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 所在区域 */
@property (weak, nonatomic) IBOutlet UILabel *lblArea;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *username;

/** 联系人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *memberName;
/** 手机 */
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;
/** 固定电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation NTGSupplierDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分销商详情";
    [self initData];
}

- (void)initData {
    NSDictionary *dict = @{@"id":self.supplier.id};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGSupplier *supplier) {
        self.lblSn.text = supplier.sn;
        self.lblName.text = supplier.name;
        self.lblArea.text = supplier.area.fullName;
        self.username.text = supplier.member.username;
        self.memberName.text = supplier.member.name;
        self.lblMobile.text = supplier.member.mobile;
        self.phone.text = supplier.member.phone;
    };
    [NTGSendRequest supplierContent:dict success:result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
