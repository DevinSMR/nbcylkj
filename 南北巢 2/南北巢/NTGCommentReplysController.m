//
//  NTGCommentReplysController.m
//  南北巢
//
//  Created by nbc on 17/4/21.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGCommentReplysController.h"
#import "NTGMemberCommentReply.h"
#import "NTGCommentReplyCell.h"
#import "NTGCommentReplyTopCell.h"
#import <IQKeyboardManager.h>
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticleDetail.h"
#import "NTGMemberComments.h"
#import "NTGMBProgressHUD.h"

#define  Width [UIScreen mainScreen].bounds.size.width
@interface NTGCommentReplysController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noticeLB;
@property (weak, nonatomic) IBOutlet UITextView *replyTV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyViewBottomHeithg;

@property (nonatomic,assign) CGFloat keyboardHeight;

@property (weak, nonatomic) IBOutlet UIView *replyBottomView;

@property (nonatomic,strong) NSMutableArray *replyArray;


@end

@implementation NTGCommentReplysController

- (IBAction)backToAciton:(id)sender {
    [self.replyTV resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showReplyViewAction:(id)sender {
    
    self.replyBottomView.hidden = NO;
    [self.replyTV becomeFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [self.replyTV becomeFirstResponder];
    [IQKeyboardManager sharedManager].enable = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor colorWithRed:242 /255.0 green:242 /255.0 blue:242 /255.0 alpha:1];
    [self keyboardNotification];
    
    self.replyArray = [NSMutableArray array];
    NSString *notice = [NSString stringWithFormat:@"回复%@ :",self.comment.member.petName];
    self.noticeLB.text = notice;
    self.replyTV.delegate = self;
    self.replyArray =[NSMutableArray arrayWithArray:self.comment.memberCommentReplys] ;
    
}


-(void)setReplyArray:(NSMutableArray *)replyArray{
    if (replyArray != nil) {
        _replyArray = replyArray;
        [self.tableView reloadData];
    }



}
-(void)setComment:(NTGMemberComment *)comment{
    if (comment != nil) {
        _comment = comment;
        [self.tableView reloadData];
    }


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

#pragma UITextView的代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.noticeLB.hidden = YES;
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self isEmpty:textView.text]) {
        self.noticeLB.hidden = NO;
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


#pragma View的代理方法
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.replyViewBottomHeithg.constant = self.keyboardHeight;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.replyTV resignFirstResponder];

}

//回复评论
- (IBAction)replyAction:(id)sender {
    
    [self.replyTV resignFirstResponder];
    if (![self isEmpty:self.replyTV.text]) {
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(id object){
            self.replyBottomView.hidden = YES;
            
            self.replyTV.text = nil;
            [self.replyTV resignFirstResponder];
            [self initData];
            
        };
        NSDictionary *dict = @{
                               @"commentId":[NSString stringWithFormat:@"%ld",self.comment.id],
                               @"replyContent":self.replyTV.text
                               
                               };
        [NTGSendRequest saveCommentReply:dict success:result];
    }else{
        self.replyTV.text = nil;
        [NTGMBProgressHUD alertView:@"评论内容不能为空" view:self.view];
    }
    
    
    
}

-(void) initData{
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGMemberArticleDetail *article){
    
        NTGMemberComments *comments = article.memberComments;
        NTGMemberComment *comment = comments.content[self.index];
        self.replyArray = [NSMutableArray arrayWithArray:comment.memberCommentReplys];
    
    };
    NSString *string = [NSString stringWithFormat:@"%ld",self.articleID];
    NSDictionary *param = @{@"memberArticleId":string};
    [NTGSendRequest getMemBerArticleDetail:param success:result];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma UITableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.replyArray.count;
            break;
        default:
            return 0;
            break;
    }
    
//    return self.comment.memberCommentReplys.count;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NTGCommentReplyTopCell *cell =(NTGCommentReplyTopCell *) [[NSBundle mainBundle] loadNibNamed:@"NTGCommentReplyTopCell" owner:nil options:nil].lastObject;;
        cell.memberComment = self.comment;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 1){
        NTGCommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[NTGCommentReplyCell alloc] init];
        }
        cell.reply = self.replyArray[indexPath.row];
        
        return cell;
    } else{
 
        return nil;
    }


}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 42)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 24, 200, 18)];
        label.text = @"全部评论";
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor blackColor];
        [view addSubview: label];
        return view;

    }
    
    return nil;




}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 42;
    }else{
    
        return CGFLOAT_MIN;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGSize size  = [self.comment.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return size.height + 74;

    }else{
        
        NTGMemberCommentReply *model = self.replyArray[indexPath.row];
        return model.cellHeight;
    }
    
//    NTGCommentReplyCell *cell = (NTGCommentReplyCell *)[tableView cellForRowAtIndexPath:indexPath];
//    return cell.cellHeight;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.replyTV resignFirstResponder];
    self.replyBottomView.hidden = YES;

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
