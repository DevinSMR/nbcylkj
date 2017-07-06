/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGReviewViewController.h"
#import "NTGSendRequest.h"
#import "NTGReviewContent.h"
#import <UIImageView+WebCache.h>

/**
 * control - 查看评价
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReviewViewController ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lnlName;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthBtn;

@end

@implementation NTGReviewViewController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.navigationItem.title = @"查看评价";
    // Do any additional setup after loading the view.
}

- (void)initData {
    NSDictionary *dict = @{@"id":self.reviewId};
    NTGBusinessResult *result = [[NTGBusinessResult alloc]initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGReviewContent *reviewContent) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:reviewContent.product.thumbnail]];
        self.lnlName.text = reviewContent.product.name;
        self.lblContent.text = reviewContent.content;
        if (reviewContent.score == 1) {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = NO;
            self.thirdBtn.selected = NO;
            self.fourthBtn.selected = NO;
            self.fifthBtn.selected = NO;
        }else if (reviewContent.score == 2) {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = YES;
            self.thirdBtn.selected = NO;
            self.fourthBtn.selected = NO;
            self.fifthBtn.selected = NO;
        }else if (reviewContent.score == 3) {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = YES;
            self.thirdBtn.selected = YES;
            self.fourthBtn.selected = NO;
            self.fifthBtn.selected = NO;
        }else if (reviewContent.score == 4) {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = YES;
            self.thirdBtn.selected = YES;
            self.fourthBtn.selected = YES;
            self.fifthBtn.selected = NO;
        }else if (reviewContent.score == 5) {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = YES;
            self.thirdBtn.selected = YES;
            self.fourthBtn.selected = YES;
            self.fifthBtn.selected = YES;
        }
    };
    [NTGSendRequest getReviewView:dict success:result];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
