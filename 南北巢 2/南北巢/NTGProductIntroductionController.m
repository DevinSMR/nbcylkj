/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGProductIntroductionController.h"

/**
 * control - 商品介绍
 *
 * @author nbcyl Team
 * @version 1.0
 */

@interface NTGProductIntroductionController ()
/** 商品详情 */
@property (weak, nonatomic) IBOutlet UIWebView *introduction;

@end

@implementation NTGProductIntroductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.introduction.scalesPageToFit = YES;
    self.introduction.backgroundColor = [UIColor clearColor];
    [self.introduction loadHTMLString:self.intro baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
