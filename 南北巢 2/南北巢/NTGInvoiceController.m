/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInvoiceController.h"

/**
 * control - 发票抬头
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGInvoiceController ()
/** 发票抬头 */
@property (weak, nonatomic) IBOutlet UITextField *invoice;

@end

@implementation NTGInvoiceController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    // Do any additional setup after loading the view.
}
/** 保存 */
- (IBAction)saveBtn:(id)sender {
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.invoice.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
