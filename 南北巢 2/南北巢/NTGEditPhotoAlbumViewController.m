//
//  NTGEditPhotoAlbumViewController.m
//  南北巢
//
//  Created by nbc on 17/4/19.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGEditPhotoAlbumViewController.h"
#import "NTGSendRequest.h"
#import "NTGBusinessResult.h"


@interface NTGEditPhotoAlbumViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;

@end

@implementation NTGEditPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextView.text = self.name;
    self.descTextView.text = self.desc;
    self.nameTextView.delegate = self;
    self.descTextView.delegate = self;
    
}
- (IBAction)editPhotoAction:(id)sender {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(id object){
        [self.navigationController popViewControllerAnimated:YES];
        self.editPhotoAlbum(self.nameTextView.text,self.descTextView.text);
    };
    NSString *ID = [NSString stringWithFormat:@"%ld",self.photoAlbum.id];
    NSDictionary *dict = @{
                           @"id":ID,
                           @"name":self.nameTextView.text,
                           @"description":self.descTextView.text
                           
                           };
    [NTGSendRequest updatePhotoAlbum:dict success:result];
    
    
    
    
    
}


- (IBAction)popVCAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//系统方法更新视图
-(void)updateViewConstraints{
    [super updateViewConstraints];
    CGSize size  = [self.nameTextView.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    if (size.height > 90) {
        self.nameViewHeight.constant = size.height;

    }else{
    
        self.nameViewHeight.constant = 90;
    
    }
    
    CGSize size2  = [self.descTextView.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    if (size2.height > 159) {
        self.photoViewHeight.constant = size2.height;
        
    }else{
        
        self.photoViewHeight.constant = 159;
        
    }

    
    
}


-(void)textViewDidChange:(UITextView *)textView{

    [self updateViewConstraints];



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
