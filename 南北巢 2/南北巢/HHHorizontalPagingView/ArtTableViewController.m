//
//  ArtTableViewController.m
//  Demo
//
//  Created by weijingyun on 16/5/28.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtTableViewController.h"
#import "JYPagingView.h"

@interface ArtTableViewController()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,assign) CGFloat webViewHeight;
@end

@implementation ArtTableViewController

- (void)loadView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.view = self.tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webViewHeight = [UIScreen mainScreen].bounds.size.height - 105;
    if (!self.allowPullToRefresh) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeBack:) name:kHHHorizontalTakeBackRefreshEndNotification object:self.tableView];
    
}


- (void)dealloc{
    NSLog(@"%s",__func__);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    self.webViewHeight = height;
//    [self.tableView reloadData];

}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
   
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height - 96)];
    [webView loadHTMLString:self.scenicRegion.introduction baseURL:nil];
    webView.delegate = self;
    [cell.contentView addSubview:webView];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height - 105;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // 通过最后一个 Footer 来补高度
    if (section == [self numberOfSectionsInTableView:tableView] - 1) {
        return [self automaticHeightForTableView:tableView];
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)automaticHeightForTableView:(UITableView *)tableView{
    
      // 36 是 segmentButtons 的高度 20 是segmentTopSpace的高度
    CGFloat height = self.fillHight;
    
    NSInteger section = [tableView.dataSource numberOfSectionsInTableView:tableView];
    for (int i = 0; i < section; i ++) {
        
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            height += [tableView.delegate tableView:tableView heightForHeaderInSection:i];
        }
        
        NSInteger row = [tableView.dataSource tableView:tableView numberOfRowsInSection:i];
        for (int j= 0 ; j < row; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
                height += [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
            }
            
            if (height >= tableView.frame.size.height) {
                return 0.0001;
            }
        }
        
        if (i != section - 1) {
            
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                height += [tableView.delegate tableView:tableView heightForFooterInSection:i];
            }
        }
        
    }
    
    if (height >= tableView.frame.size.height) {
        return 0.0001;
    }
    
    return tableView.frame.size.height - height;
}

@end
