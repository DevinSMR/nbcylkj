/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */
#import "NTGCreatPhotoAlbumController.h"
#import "NTGBusinessResult.h"
#import "NTGSendRequest.h"
#import "NTGManagePhotoController.h"
#import <MBProgressHUD.h>
/**
 * control - 创建相册
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGCreatPhotoAlbumController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleTint;
@property (weak, nonatomic) IBOutlet UITextView *photoNameTV;
@property (weak, nonatomic) IBOutlet UILabel *decriptTint;

@property (weak, nonatomic) IBOutlet UITextView *decriptionTV;

//加载页面中
@property (nonatomic,retain) MBProgressHUD *hud;
@end

@implementation NTGCreatPhotoAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建相册";
    self.photoNameTV.delegate = self;
    self.photoNameTV.tag = 20001;
    self.decriptionTV.delegate = self;
    self.decriptionTV.tag = 20002;
    self.navigationController.navigationBar.translucent = NO;
    
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 20001) {
        if (textView.text.length == 0) {
            self.titleTint.hidden = NO;
        }
    }
    else{
        
        if (textView.text.length == 0) {
            self.decriptTint.hidden = NO;
        }
        
        
    }
//    if (textView.tag == 20002) {
//        if (textView.text.length == 0) {
//            self.decriptTint.hidden = NO;
//        }
//
//    }
    



}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 20001) {
        self.titleTint.hidden = YES;
    }else{
        self.decriptTint.hidden = YES;
        
    }
}

-(BOOL)checkDescript{
    if (self.decriptionTV.text.length == 0 || self.photoNameTV.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"相册名称和描述不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        
        
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击确认");
            
        }]];
          [self presentViewController:alertC animated:YES completion:nil];
        return NO;
    }else{
    
        return YES;
    }


}
- (IBAction)creatPhotoAlbumAction:(id)sender {
    if ([self checkDescript]) {
        
        [self addHudWithMessage:@"正在创建"];
        NSDictionary *param = @{@"name":self.photoNameTV.text,@"description":self.decriptionTV.text};
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            [self removeHud];
            self.scrollToRow();
            [self.navigationController popViewControllerAnimated:YES];
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
//            NTGManagePhotoController *managerVC = [storyboard instantiateViewControllerWithIdentifier:@"managerPhoto"];
//            managerVC.name = self.photoNameTV.text;
//            managerVC.descript = self.decriptionTV.text;
//            [self.navigationController pushViewController:managerVC animated:YES];
            
        };
        result.onFail = ^(id object){
        
            [self removeHud];
        };
        
        [NTGSendRequest createPhotoAlbum:param  success:result];
        
       // [NTGSendRequest createRoomOrder:param success:result];
        
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];


}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
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
