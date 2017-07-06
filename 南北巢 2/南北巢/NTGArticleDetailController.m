/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGArticleDetailController.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticle.h"
#import "NTGMemberArticleDetail.h"
#import <UIImageView+WebCache.h>
#import "NTGArticleCommentsController.h"
#import "NTGMBProgressHUD.h"
/**
 * control - 文章详情
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGArticleDetailController ()


//创建日期
@property (weak, nonatomic) IBOutlet UILabel *createDate;


@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *commentSnum;

//点赞数量
@property (weak, nonatomic) IBOutlet UILabel *priseNum;

//文章标题
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UIButton *priseBtn;
@property (nonatomic,strong) NTGMemberArticleDetail *articleDetail;
@end

@implementation NTGArticleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章详情";
    
    
}

-(void)initData{
    self.contentTextView.editable = NO;
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMemberArticleDetail *articleDetail){
        self.articleDetail = articleDetail;
        self.titleLB.text = articleDetail.article.title;
        self.createDate.text = [self dateFromString:articleDetail.article.createDate];
        self.contentTextView.text = articleDetail.article.introduction;

        self.priseNum.text = [NSString stringWithFormat:@"%d",articleDetail.article.memberPraiseNum];
 
        self.commentSnum.text = [NSString stringWithFormat:@"%ld",articleDetail.article.commentNum];
        if (self.articleDetail.memberPraiseId) {
            self.priseBtn.selected = YES;
        }else{
            
            self.priseBtn.selected = NO;
        }
        
        
    };
    NSString *string = [NSString stringWithFormat:@"%ld",self.memberArticleId];
    NSDictionary *param = @{@"memberArticleId":string};
    [NTGSendRequest getMemBerArticleDetail:param success:result];
    

}
-(NSString *)dateFromString:(NSString *)string{
    NSString*time = string;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:SS"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    return confromTimespStr;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initData];

}

//点赞
- (IBAction)priseAction:(id)sender {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id object){
        NSDictionary *dict = (NSDictionary *)object;
        self.priseBtn.selected = !self.priseBtn.selected;
        NSNumber *num = [dict valueForKey:@"num"];
        self.priseNum.text = [NSString stringWithFormat:@"%@",num];
    };
    NSDictionary *dict = @{@"dataId":[NSString stringWithFormat:@"%ld",self.memberArticleId], @"dataType":@"article"};
    
    [NTGSendRequest savePraise:dict success:result];
    
    
    
}
//查看评论
- (IBAction)comments:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGArticleCommentsController *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"articleComments"];
    commentsVC.comments = self.articleDetail.memberComments;
    commentsVC.memberArticleId = self.memberArticleId;
    [self.navigationController pushViewController:commentsVC animated:YES];

//    if (self.articleDetail.memberComments.content.count > 0) {
//
//        
//        
//    }else{
//    
//        [NTGMBProgressHUD alertView:@"当前还没有人对您的文章进行评论" view:self.view];
//    
//    }
    
    
    
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
