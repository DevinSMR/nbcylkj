//
//  NTGPublishCommentController.m
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGPublishCommentController.h"
#import "NTGMBProgressHUD.h"
#import <UIImageView+WebCache.h>
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"

@interface NTGPublishCommentController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *memberIcon;
@property (weak, nonatomic) IBOutlet UILabel *memberName;

@property (weak, nonatomic) IBOutlet UILabel *noticeLb;


@property (weak, nonatomic) IBOutlet UITextView *content;
@end

@implementation NTGPublishCommentController
- (IBAction)backToAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.delegate = self;
    self.memberIcon.layer.masksToBounds = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *icon = [defaults objectForKey:@"icon"];
    NSString *name = [defaults objectForKey:@"petName"];
    [self.memberIcon sd_setImageWithURL:[NSURL URLWithString:icon]];
    self.memberName.text = name;
    
    
    
    
    
}
- (IBAction)publishCommentAction:(id)sender {
    [self.content resignFirstResponder];

    if (![self isEmpty:self.content.text]) {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess= ^(id  object){
            self.refuresh();
            [self.navigationController popViewControllerAnimated:NO];
        };
        
        
        NSDictionary *dict = @{
                               @"id":[NSString stringWithFormat:@"%ld",self.memberArticleId],
                               @"content":self.content.text,
                               @"dataType":@"article"
                               
                               };
        [NTGSendRequest saveComment:dict success:result];
        
        
    }else{
        self.content.text = nil;
        [NTGMBProgressHUD alertView:@"评论内容不能为空" view:self.view];
    }
}

//判断输入的字符串是否为空，或者只有空格
-(BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        
        return YES;
        
    } else {
        
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        
        
        if ([trimedString length] == 0) {
            
            return YES;
            
        } else {
            
            return NO;
            
        }
        
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.noticeLb.hidden = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self isEmpty:self.content.text] ) {
        self.noticeLb.hidden = NO;
    }




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
