/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMySetupController.h"
#import "NTGSendRequest.h"
#import "NTGAppVersion.h"
//#import <SDImageCache.h>
#import "NTGMBProgressHUD.h"

/**
 * control - 设置
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMySetupController ()<NSCoding,UIAlertViewDelegate>
/** 用户退出 */
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
/** 当前版本信息 */
@property (weak, nonatomic) IBOutlet UILabel *version;
/** 缓存 */
@property (weak, nonatomic) IBOutlet UILabel *cashing;

@end

@implementation NTGMySetupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.cashing.text = [[NSString stringWithFormat:@"%.1f",[self filePath]] stringByAppendingString:@"M"];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [userDefaults objectForKey:@"isLogin"];
    if ([isLogin isEqualToString:@"1"]) {
        self.exitBtn.hidden = NO;
    }else{
    
        self.exitBtn.hidden = YES;
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 获取版本信息 */
- (void)initData {
    NSDictionary *dict = @{@"appType":@"ios"};
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGAppVersion *appVersion) {
        
        NSString *str = @"当前版本";
        if (appVersion.versionName == nil) {
           appVersion.versionName = @"1.0";
        }
        self.version.text = [str stringByAppendingString:appVersion.versionName];
    };
    [NTGSendRequest getVersion:dict success:result];
}

/** 清除缓存 */
- (IBAction)cleanBtn:(id)sender {
    NSString *mess = [NSString stringWithFormat:@"缓存大小为%@,确定要清理缓存吗？",[[NSString stringWithFormat:@"%.1f",[self filePath]] stringByAppendingString:@"M"]];
    UIAlertView *genderPicker = [[UIAlertView alloc]initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    [genderPicker show];
    
}

/** 用户退出 */
- (IBAction)exitBtn:(id)sender {
    //注销
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(id responseObject) {
        self.exitBtn.hidden = YES;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"name"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults setObject:[NSString stringWithFormat:@"%d",0] forKey:@"isLogin"];
        [userDefaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NTGSendRequest loginOut:nil success:result];
}

/** 弹框 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 1) {
       [self clearFile];
    }
}

// 显示缓存大小
- (float)filePath {
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [self folderSizeAtPath:cachPath];
}

//1:首先我们计算一下 单个文件的大小

- (long long)fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}

//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- (float)folderSizeAtPath:(NSString *)folderPath {
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
    
}

// 清理缓存
- (void)clearFile {
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
//    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone: YES ];
}

-(void)clearCachSuccess {
    self.cashing.text = [[NSString stringWithFormat:@"%.1f",[self filePath]] stringByAppendingString:@"M"];
    [NTGMBProgressHUD alertView:@"清理成功" view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
