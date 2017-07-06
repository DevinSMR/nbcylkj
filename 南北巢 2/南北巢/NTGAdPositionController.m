/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAdPositionController.h"
#import "NTGAd.h"

/**
 * control - 促销活动
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGAdPositionController ()
/** 广告内容 */
@property (weak, nonatomic) IBOutlet UIWebView *contents;

@end

@implementation NTGAdPositionController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.ad.title;
    [self.contents loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.ad.url]]];
    [self.contents setScalesPageToFit:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
