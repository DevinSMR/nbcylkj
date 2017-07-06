//
//  NTGShowPicDetailVC.m
//  南北巢
//
//  Created by nbc on 17/4/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGShowPicDetailVC.h"
#import "NTGMemberPhoto.h"
#import <UIImageView+WebCache.h>
@interface NTGShowPicDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation NTGShowPicDetailVC
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(WIDTH *self.photoAlbum.count,0);
    self.scrollView.pagingEnabled = YES;
    for (int i = 0; i < self.photoAlbum.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        NTGMemberPhoto *photo = self.photoAlbum[i];
        [imgV sd_setImageWithURL:[NSURL URLWithString:photo.path] placeholderImage:[UIImage imageNamed:@"pictureReplace"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPopView:)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [imgV addGestureRecognizer:tap];
        [view addSubview:imgV];
        [view addGestureRecognizer:tap];
        [self.scrollView addSubview:view];
        
    }
    
    
    
}

-(void)clickPopView:(UIPanGestureRecognizer *)pan{
    
    NSLog(@"这个方法走了");
    [self.navigationController popViewControllerAnimated:NO];

}
-(void)viewWillAppear:(BOOL)animated{
    self.scrollView.contentOffset = CGPointMake(self.index * WIDTH, 0);

    [self.navigationController setNavigationBarHidden:YES];

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
