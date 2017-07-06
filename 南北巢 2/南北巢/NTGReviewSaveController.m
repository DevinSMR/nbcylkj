/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGReviewSaveController.h"
#import "NTGSendRequest.h"
#import "NTGMBProgressHUD.h"

/**
 * control - 发表评价
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGReviewSaveController ()<UITextViewDelegate>
/** 评价内容 */
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthBtn;
/** 分数 */
@property (nonatomic,assign) int score;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@end

@implementation NTGReviewSaveController
/** 退出 */
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textViewContent.delegate = self;
    self.navigationItem.title = @"发表评价";
}

/** 退出 */
- (IBAction)selectedBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        self.firstBtn.selected = !self.firstBtn.selected;
        self.secondBtn.selected = NO;
        self.thirdBtn.selected = NO;
        self.fourthBtn.selected = NO;
        self.fifthBtn.selected = NO;
        if (self.firstBtn.selected) {
            self.score = 1;
        }
    }if (btn.tag == 200) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = !self.secondBtn.selected;
        self.thirdBtn.selected = NO;
        self.fourthBtn.selected = NO;
        self.fifthBtn.selected = NO;
        if (self.secondBtn.selected) {
            self.score = 2;
        }else {
            self.score = 1;
        }
    }if (btn.tag == 300) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = YES;
        self.thirdBtn.selected = !self.thirdBtn.selected;
        self.fourthBtn.selected = NO;
        self.fifthBtn.selected = NO;
        if (self.thirdBtn.selected) {
            self.score = 3;
        }else {
            self.score = 2;
        }
    }if (btn.tag == 400) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = YES;
        self.thirdBtn.selected = YES;
        self.fourthBtn.selected = !self.fourthBtn.selected;
        self.fifthBtn.selected = NO;
        if (self.fourthBtn.selected) {
            self.score = 4;
        }else {
            self.score = 3;
        }
    }if (btn.tag == 500 ) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = YES;
        self.thirdBtn.selected = YES;
        self.fourthBtn.selected = YES;
        self.fifthBtn.selected = !self.fifthBtn.selected;
        if (self.fifthBtn.selected) {
            self.score = 5;
        }else {
            self.score = 4;
        }
    }
}

- (void)initData {
    NSDictionary *dict = nil;
    if (self.score<1 ||self.textViewContent.text.length<1) {
        [NTGMBProgressHUD alertView:@"亲，请填写内容!" view:self.view];
    }else {
        dict = @{
                 @"id":self.productId,
                 @"score":[NSString stringWithFormat:@"%d",self
                           .score],
                 @"content":self.textViewContent.text
                 };
        NTGBusinessResult *result = [[NTGBusinessResult alloc]initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            [self.navigationController popViewControllerAnimated:YES];
        };
        [NTGSendRequest getReviewSave:dict success:result];
    }
}

/** 发表评论 */
- (IBAction)reportBtn:(id)sender {
    [self initData];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    
    if (_textViewContent.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeholder.hidden=NO;//隐藏文字
        }else{
            _placeholder.hidden=YES;
        }
    }else{//textview长度不为0
        if (_textViewContent.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeholder.hidden=NO;
            }else{//不是删除
                _placeholder.hidden=YES;
            }
        }else{//长度不为1时候
            _placeholder.hidden=YES;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
