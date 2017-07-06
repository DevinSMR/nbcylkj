//
//  NTGPublisAriticleVC.m
//  南北巢
//
//  Created by nbc on 17/4/20.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGPublisAriticleVC.h"
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticleCategory.h"
#import "NTGMemberArticleDetail.h"
#import <MBProgressHUD.h>

@interface NTGPublisAriticleVC ()<UITextViewDelegate>
//标题
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
//分类
@property (weak, nonatomic) IBOutlet UILabel *classfiyLable;
//输入提示
@property (weak, nonatomic) IBOutlet UILabel *ariticleLb;
//文章正文
@property (weak, nonatomic) IBOutlet UITextView *articleTV;

@property (nonatomic,strong) UIView *editView;

@property (nonatomic,strong) NSArray *titleArray;

//文章分类ID
@property (nonatomic,strong) NSString *ID;

//导航栏标题
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleContentHeight;

@property (nonatomic,assign) CGFloat keyboardHeight;

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation NTGPublisAriticleVC
//选择分类
- (IBAction)displayClassfiy:(id)sender {
    
    [self checkArticleClassfiy];
    
    
}


//查询文章分类
-(void)checkArticleClassfiy{
    NTGBusinessResult *request = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    request.onSuccess = ^(NSArray *array){
        self.titleArray = array;
     
    };
    [NTGSendRequest getMemberArticleCategory:nil success:request];

    

}

-(void)setTitleArray:(NSArray *)titleArray{
    if (titleArray.count > 0) {
        _titleArray = titleArray;
        
        self.editView = [[UIView alloc] initWithFrame:self.view.frame];
        self.editView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        NSArray *titleArray = @[@"养老生活",@"旅游日记",@"商品体验"];
        for (int i = 0 ; i < self.titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat wide = ([UIScreen mainScreen].bounds.size.width - 250) /2.0;
            button.frame = CGRectMake(wide, 186 + 50 * i, 250, 49);
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor colorWithRed:55 /255.0 green:55 /255.0 blue:55 /255.0 alpha:1]forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize: 15];
            NTGMemberArticleCategory *category = self.titleArray[i];
            [button setTitle:category.name forState:UIControlStateNormal];
            button.tag = 1000  + category.id;
            
            [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.editView addSubview:button];
            
        }
        [self.view addSubview:self.editView];
        [self.view bringSubviewToFront:self.editView];
        

        
    }



}

-(void)didClick:(UIButton *) btn{
    self.classfiyLable.text = btn.titleLabel.text;
    self.ID = [NSString stringWithFormat:@"%ld",btn.tag -1000];
    NSLog(@"%@",self.ID);
    [self.editView removeFromSuperview];




}
- (IBAction)publicArticleAction:(id)sender {
    if ([self.pageTitle.text isEqualToString:@"编辑文章"]) {
        NTGBusinessResult *result = [[ NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(id object){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        ;
        NSDictionary *dict = @{
                               @"id":[NSString stringWithFormat:@"%ld",self.article.id],
                               @"articleCategoryId":self.ID,
                               @"title":self.titleTF.text,
                               @"introduction":self.articleTV.text
                               };
        [NTGSendRequest editMemBerArticle:dict success:result];
        
    }else{
    
        if ([self checkTitleAndContent]) {
            [self addHudWithMessage:@"正在发表"];
            NTGBusinessResult *result = [[ NTGBusinessResult alloc] initWithNavController:self.navigationController];
            result.onSuccess = ^(id object){
                [self removeHud];
                [self.navigationController popViewControllerAnimated:YES];
                
            };
            
            result.onFail = ^(id object){
            
                [self removeHud];
            
            };
            NSDictionary *dict = @{
                                   @"articleCategoryId":self.ID,
                                   @"title":self.titleTF.text,
                                   @"introduction":self.articleTV.text
                                   };
            [NTGSendRequest saveMemBerArticle:dict success:result];
            
        }
    }
    
}


- (void)addHudWithMessage:(NSString*)message
{
    if (!_hud)
    {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.labelText=message;
    }
    
}
- (void)removeHud
{
    if (_hud) {
        [_hud removeFromSuperview];
        _hud=nil;
    }
}


-(BOOL)checkTitleAndContent{
    
    if (self.titleTF.text.length > 0 && self.articleTV.text.length > 0 ) {
        return YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"标题和内容不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
        return NO;
    }

}
- (IBAction)backToAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = [NSMutableArray array];
    self.ID = @"52";
    self.articleTV.delegate = self;
    if (self.article != nil) {
        self.ariticleLb.hidden = YES;
        self.pageTitle.text = @"编辑文章";
        self.articleTV.text = self.article.introduction;
        self.ID = [NSString stringWithFormat:@"%ld",self.article.memberArticleCategory.id];
        self.classfiyLable.text = self.article.memberArticleCategory.name;
        self.titleTF.text = self.article.title;

        
        
    }
    
    [self keyboardNotification];
    
    
}

//监听键盘事件

-(void)keyboardNotification{
    //增加监听，当键盘出现或改变时收出消息
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加监听，当键退出时收出消息
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

//当键盘出现或改变时调用

- (void)keyboardDidShow:(NSNotification *)aNotification

{
    
    //获取键盘的高度
    
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    self.keyboardHeight = keyboardRect.size.height;
    [self updateViewConstraints];
    
    
}
//当键退出时调用

- (void)keyboardDidHide:(NSNotification *)aNotification

{
    self.keyboardHeight = 0;
    [self updateViewConstraints];
    NSLog(@"-----键盘隐藏!------");
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    self.articleContentHeight.constant = self.keyboardHeight;




}



-(void)textViewDidBeginEditing:(UITextView *)textView{

    self.ariticleLb.hidden = YES;



}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.ariticleLb.hidden = NO;
    }
  

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;


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
