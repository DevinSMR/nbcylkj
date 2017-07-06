/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGInspirationController.h"
#import "NTGSendRequest.h"
#import "NTGMemberArticleDetail.h"
#import "NTGArticleCommentsController.h"
#import "NTGMemberArticleDetail.h"
#import "UILabel+StringFrame.h"

/**
 * control - 巢友帮
 *
 * @author nbcyl Team
 * @version 3.0
 */

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface NTGInspirationController ()<UIWebViewDelegate>
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/** 评论数 */
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
/** 点赞数 */
//@property (weak, nonatomic) IBOutlet UILabel *memberPraiseNum;
@property (weak, nonatomic) IBOutlet UILabel *memberPraise;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UIWebView *webIntro;

@property (weak, nonatomic) IBOutlet UIButton *priseBtn;

@property (nonatomic,strong) NTGMemberArticleDetail *articleDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;

@end

@implementation NTGInspirationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"感悟";
    self.lblName.text = self.memberArticle.title;
    NSString*time = self.memberArticle.createDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    self.lblTime.text = confromTimespStr;
    self.memberPraise.text = [NSString stringWithFormat:@"%d",self.memberArticle.memberPraiseNum];

    self.commentNum.text = [NSString stringWithFormat:@"%ld",self.memberArticle.commentNum];
    [self.webIntro loadHTMLString:self.memberArticle.introduction baseURL:nil];
    self.webIntro.delegate = self;
    
    [self updateViewConstraints];
    
}
-(void)updateViewConstraints{
    
    [super updateViewConstraints];
   CGSize size = [self.lblName boundingRectWithSize:CGSizeMake(kScreenWidth , 0)];
    
    self.titleHeight.constant = size.height + 10 > 40 ? size.height  + 10 : 40;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
                                                     "script.type = 'text/javascript';"
                                                     "script.text = \"function ResizeImages() { "
                                                     "var myimg,oldwidth;"
                                                     "var maxwidth = %f;" // UIWebView中显示的图片宽度
                                                     "var maxheight = maxwidth*9/16.0;"
                                                     "for(i=0;i <document.images.length;i++){"
                                                     "myimg = document.images[i];"
                                                     "if(myimg.width > maxwidth){"
                                                     "oldwidth = myimg.width;"
                                                     "myimg.width = maxwidth;"
                                                     "myimg.height = maxheight;"
                                                     
                                                     "}"
                                                     "}"
                                                     "}\";"
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",kScreenWidth - 30]];
    //文本的对齐方式
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.textAlign = 'justify';"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];    //页面背景色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F5F5F5'"];
//    //字体大小
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '110%'"];//修改百分比即可
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('img')[%d].style.width = '100%'"];

    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self initData];

}

-(void)initData{
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMemberArticleDetail *articleDetail){
      self.priseBtn.selected =  articleDetail.memberPraiseId ?  YES :  NO;
        self.memberPraise.text =  [NSString stringWithFormat:@"%d",articleDetail.article.memberPraiseNum];
        self.commentNum.text = [NSString stringWithFormat:@"%ld",articleDetail.article.commentNum];
        self.commentsNum(self.commentNum.text);
        self.articleDetail = articleDetail;
    };
//    NSString *string = [NSString stringWithFormat:@"%ld",self.memberArticle.id];
    NSString *detailUrl = [NSString stringWithFormat:@"/app/privacy/member/homepage/viewcyb/%ld/%ld.jhtml",self.memberArticle.id,self.memberArticle.member.id];
    NSDictionary *param = @{@"url":detailUrl};

//    [NTGSendRequest getMemBerArticleDetail:param success:result];
    [NTGSendRequest getJuntoDetail:param success:result];
    
    
}



/** 点赞 */
- (IBAction)savePraise:(id)sender {
    NSDictionary *dict = @{
                           @"dataId":[NSString stringWithFormat:@"%ld",self.memberArticle.id],
                           @"dataType":@"article"
                           };
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGMemberArticleDetail *memberArticleDetail) {
        self.priseBtn.selected = !self.priseBtn.selected;
        self.memberPraise.text =[NSString stringWithFormat:@"%d",memberArticleDetail.num] ;
        NSString *num = [NSString stringWithFormat:@"%d",memberArticleDetail.num];
        self.priseNum(num);
    };
   // [NTGSendRequest savePraise:dict success:result];
    if (self.priseBtn.selected) {
        [NTGSendRequest noLoginCanclePraise:dict success:result];

    }else{
        [NTGSendRequest noLoginSavePraise:dict success:result];

    }
}

/** 评论 */
- (IBAction)saveArticleCommentReply:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGArticleCommentsController *commentsVC= [storyboard instantiateViewControllerWithIdentifier:@"articleComments"];
    commentsVC.comments = self.articleDetail.memberComments;
    commentsVC.memberArticleId = self.memberArticle.id;
    [self.navigationController pushViewController:commentsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
