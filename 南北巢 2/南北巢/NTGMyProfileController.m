/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMyProfileController.h"
#import <UIImageView+WebCache.h>
#import "NTGSendRequest.h"
#import "NTGMember.h"
#import "NTGUpdateMemberController.h"
#import "NTGDatepickerView.h"
#import "EQPageCycleSize.h"
#import "NTGVerificationController.h"
#import "UIImage+ScreenShot.h"
#import "NTGReceiverListController.h"
#import "NTGPage.h"
#import "NTGReceiverContent.h"
#import "NTGStringUtils.h"

/**
 * control - 我的资料
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMyProfileController ()<UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *petName;
/** 真实姓名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 性别 */
@property (weak, nonatomic) IBOutlet UILabel *gender;
/** 出生日期 */
@property (weak, nonatomic) IBOutlet UILabel *birth;
/** 手机号 */
@property (weak, nonatomic) IBOutlet UILabel *mobile;
/** 邮箱 */
@property (weak, nonatomic) IBOutlet UILabel *email;
/** 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *consignee;
/** 收货人电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 收货人地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** 日期字符串 */
@property (nonatomic,copy) NSString *nsdate;
@property (nonatomic,strong) NTGDatepickerView *datepickerView;
/** 日期选择器的日期 */
@property (nonatomic,strong) NSDate *selected;
@property (nonatomic,strong) NTGMember *member;

@end

@implementation NTGMyProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的资料";
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 25;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    [self getReceiverList];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

/** 请求数据 */
- (void) initData {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGMember *member) {
        self.member = member;
        NSString * userPhoto = [NTGStringUtils addHttpPrefix:member.picture];
        
        //记录用户头像地址
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userPhoto forKey:@"user_photo_"];
        [userDefaults synchronize];
        
        
       // self.iconView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userPhoto]]];
        
        [[SDImageCache sharedImageCache] removeImageForKey:userPhoto];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:userPhoto] placeholderImage:nil options:SDWebImageRefreshCached];
        
        if (member.petName) {
            self.petName.text = member.petName;
        }else {
            self.petName.text = @"";
        }
        if (member.name) {
            self.name.text = member.name;
        }else {
            self.name.text = @"";
        }
        if ([member.gender isEqualToString:@"male"]) {
            self.gender.text = @"男";
        }else if ([member.gender isEqualToString:@"female"]) {
            self.gender.text = @"女";
        }else {
            self.gender.text = @"";
        }
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:(member.birth/1000)];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        self.nsdate=[format stringFromDate:date];
        if (self.nsdate) {
            self.birth.text = self.nsdate;
        }else {
            self.birth.text = @"";
        }
        if (member.mobile) {
            NSString *tel = [member.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.mobile.text = tel;
        }else {
            self.mobile.text = @"";
        }
        if (member.email) {
            self.email.text = member.email;
        }else {
            self.email.text = @"";
        }
    };
    [NTGSendRequest getProfile:nil success:result];
}

/** 获取地址列表 */
- (void)getReceiverList {
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
    result.onSuccess = ^(NTGPage *page) {
        for (int i=0; i<page.content.count; i++) {
            NTGReceiverContent *receiver = page.content[i];
            if (receiver.isDefault) {
                self.consignee.text = receiver.consignee;
                self.phone.text = receiver.phone;
                self.address.text = [receiver.areaName stringByAppendingString:receiver.address];
            }
        }
    };
    [NTGSendRequest getReceiverList:nil success:result];
}

/** 选择照片 */
- (IBAction)choosePicture:(id)sender {
    UIAlertView *alertChoose = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"选择照片",@"本地图库",nil];
    alertChoose.tag = 1000;
    [alertChoose show];
}

/** 更新用户信息 */
- (IBAction)updateMemberBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSDictionary *dict = nil;
    if (btn.tag == 100) {
        if (!self.member.petName) {
            self.member.petName = @"";
        }
        dict = @{
                 @"text":self.member.petName,
                 @"_updateMember_":@"我的资料"
                 };
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGUpdateMember" bundle:nil];
        NTGUpdateMemberController *updateMemberController = [storyboard instantiateInitialViewController];
        updateMemberController.repram = dict;
        updateMemberController.member = self.member;
        [self.navigationController pushViewController:updateMemberController animated:YES];
    }else if (btn.tag == 200) {
        if (!self.member.name) {
            self.member.name = @"";
        }
        dict = @{
                 @"text":self.member.name,
                 @"_updateMember_":@"真实姓名"
                 };
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGUpdateMember" bundle:nil];
        NTGUpdateMemberController *updateMemberController = [storyboard instantiateInitialViewController];
        updateMemberController.repram = dict;
        updateMemberController.member = self.member;
        [self.navigationController pushViewController:updateMemberController animated:YES];
    }else if (btn.tag == 300) {
        UIAlertView *genderPicker = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"女" otherButtonTitles:@"性别",@"男",nil];
        genderPicker.tag = 2000;
        [genderPicker show];
    }else if (btn.tag == 400) {
        self.datepickerView = [NTGDatepickerView viewWithView];
        self.datepickerView.frame = CGRectMake(0, 400, UI_CURRENT_SCREEN_WIDTH, UI_SCREEN_HEIGHT-400);
        [self.view addSubview:self.datepickerView];
//        self.datepickerView.datePicker.date = [NSDate dateWithTimeIntervalSince1970:(self.member.birth/1000)];
        [NTGDatepickerView beginAnimations:nil context:nil];
        [NTGDatepickerView setAnimationDuration:2];
        [NTGDatepickerView commitAnimations];
        [self.datepickerView.datePicker addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
        [self.datepickerView.doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    }else if (btn.tag == 500) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGVerification" bundle:nil];
        NTGVerificationController *verificationController = [storyboard instantiateInitialViewController];
        verificationController.member = self.member;
        [self.navigationController pushViewController:verificationController animated:YES];

    }else if (btn.tag == 600) {
        if (self.member.email == nil) {
            self.member.email = @"";
        }
//        [NTGValidateMobile validateEmail:self.member.email];
        
        dict = @{
                 @"text":self.member.email,
                 @"_updateMember_":@"邮箱"
                 };
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGUpdateMember" bundle:nil];
        NTGUpdateMemberController *updateMemberController = [storyboard instantiateInitialViewController];
        updateMemberController.repram = dict;
        updateMemberController.member = self.member;
        [self.navigationController pushViewController:updateMemberController animated:YES];
    }else if (btn.tag == 700) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGReceiver" bundle:nil];
        NTGReceiverListController *receiverListController = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:receiverListController animated:YES];
    }
}

/** 选择性别 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2000) {
        NSString *gender = nil;
        if (buttonIndex == 0) {
            gender = @"female";
        }else if (buttonIndex == 2) {
            gender = @"male";
        }else if (buttonIndex == 1) {
            if ([self.gender.text isEqualToString:@"男"]) {
                gender = @"male";
            }else if ([self.gender.text isEqualToString:@"女"]) {
                gender = @"female";
            }
        }
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:(self.member.birth/1000)];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *ndate=[format stringFromDate:date];
        if (self.member.id == 0) {
            return;
        }
        if (gender == nil) {
//            gender = @"";
            return;
        }
        if (ndate == nil) {
            return;
        }
        NSDictionary *dict = @{
                               @"id":[NSString stringWithFormat:@"%ld",self.member.id],
                               @"gender":gender,
                               @"birth":ndate
                               };
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(id responseObject) {
            if ([gender isEqualToString:@"male"]) {
                self.gender.text = @"男";
            }else if ([gender isEqualToString:@"female"]) {
                self.gender.text = @"女";
            }
        };
        [NTGSendRequest getUpdateMember:dict success:result];
    }
    if (alertView.tag == 1000) {
//        if (buttonIndex == 2) {
//            BOOL isCamera = [UIImagePickerController
//                        isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//            if (!isCamera) {
//                return;
//            }
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
//            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//            [self presentViewController:imagePicker animated:YES
//             completion:^{}];
//        }else
        if (buttonIndex == 1) {
            
        }
        if (buttonIndex == 2) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:imagePicker animated:YES
                             completion:^{}];
        }
    }
}

/** 选中照片 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImagePickerControllerOriginalImage 原始图片
//    UIImagePickerControllerEditedImage 编辑后图片
    //self.iconView.image = nil;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize imagesize = image.size;
    imagesize.height =250;
    imagesize.width =250;
    //对图片大小进行压缩--
    image = [image imageByScalingAndCroppingForSize:imagesize];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
     NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    NSDictionary *parameters = @{
                                @"id":[NSString stringWithFormat:@"%ld",self.member.id]
                                };
    
    NSDictionary *multipartFormDataDict = @{
                                 @"file":filePath
                                 };
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:NO];
    result.onSuccess = ^(NSString *operate) {
        self.iconView.image = image;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:operate forKey:@"icon"];
        [defaults synchronize];
    };
    
    [NTGSendRequest getUpdateMemberHead:parameters multipartFormData:multipartFormDataDict success:result];
    
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://m.nbcyl.com/nbcylapp/app/member/profile/updateMemberHead.jhtml" parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" error:nil];
        }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.iconView.image = image;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];*/
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    
}

/** 取消相册 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

/** 选择日期 */
- (void)click {
    self.selected = [self.datepickerView.datePicker date];
}

/** 完成 */
- (void)doneClick {
    [self.datepickerView removeFromSuperview];

    if (self.selected) {
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *ndate=[format stringFromDate:self.selected];
        NSDictionary *dict = @{
                               @"id":[NSString stringWithFormat:@"%ld",self.member.id],
                               @"birth":ndate
                               };
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController removePreCtrol:YES];
        result.onSuccess = ^(NTGMember *member) {
            [self initData];
        };
        [NTGSendRequest getUpdateMember:dict success:result];
    }
//    [NTGDatepickerView beginAnimations:nil context:nil];
//    [NTGDatepickerView setAnimationDuration:2];
//    [NTGDatepickerView commitAnimations];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
