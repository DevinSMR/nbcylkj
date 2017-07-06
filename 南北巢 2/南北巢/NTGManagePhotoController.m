//
//  NTGManagePhotoController.m
//  南北巢
//
//  Created by nbc on 17/4/17.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGManagePhotoController.h"
#import <AFNetworking.h>
#import "cameraHelper.h"
#import "UIImage+ScreenShot.h"
#import "NTGPhotoCollectionViewCell.h"
#import "NTGShowPicDetailVC.h"
#import "NTGEditPhotoAlbumViewController.h"
#import "NTGSendRequest.h"
#import "NTGBusinessResult.h"
#import "NTGPage.h"
#import "NTGLoginController.h"
#import "QBImagePickerController.h"
#import <MBProgressHUD.h>
//最大的上传图片张数
#define kupdateMaximumNumberOfImage 9
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface NTGManagePhotoController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
///相册名称视图
@property (weak, nonatomic) IBOutlet UIView *nameView;
///相册视图
@property (weak, nonatomic) IBOutlet UIView *photoView;
///底层scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
///相册名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///创建日期

@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;

///相册描述
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
///包含图片的视图

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;

@property (nonatomic,strong) NSMutableArray *articleIDArray;


@property (nonatomic,assign) BOOL isDelete;


@property (weak, nonatomic) IBOutlet UIButton *manageBtn;

@property (nonatomic,strong) NSMutableArray *imageMutableArray;


@property (nonatomic,strong) NSMutableArray *photoArray;


@property (nonatomic,strong) UIView *editView;

@property (nonatomic,strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;




@end

@implementation NTGManagePhotoController
- (IBAction)backToAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)managerAction:(id)sender {
    
    
    if ([self.manageBtn.titleLabel.text isEqualToString:@"管理"]) {
        self.editView = [[UIView alloc] initWithFrame:self.view.frame];
        self.editView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
        [self.editView addGestureRecognizer:tap];
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(WIDTH - 188, 76, 176, 56);
        [editBtn setBackgroundImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
        [editBtn setTitle:@"编辑相册" forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editPhotoAlbumAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(WIDTH - 188, 134, 176, 44);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"批量删除图片" forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deletePhotoAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.editView addSubview:editBtn];
        [self.editView addSubview:deleteBtn];
        [self.view addSubview:self.editView];
        [self.view bringSubviewToFront:self.editView];

    }else{
        self.uploadBtn.hidden = NO;

        NSString *selectIDS = [self getAllSelectArticleIds];
        self.isDelete = NO;
        
        NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
        result.onSuccess = ^(id object){
            [self initData];
        };
        [NTGSendRequest deletePhotos:@{@"ids":selectIDS} success:result];
        [self.manageBtn setTitle:@"管理" forState:UIControlStateNormal];
    }
    
 }

-(void) initData{
    [self addHudWithMessage:@"正在加载"];
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    result.onSuccess = ^(NTGPage *object){
        [self removeHud];
        self.photoArray = [NSMutableArray arrayWithArray:object.content];
    
    };
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *memberID = [userDefaults objectForKey:@"ID"];

    NSString *photoAlbumID = [NSString stringWithFormat:@"%ld",self.photoAlbum.id];
    NSDictionary *dict = @{@"memberId":memberID,@"photoAlbumId":photoAlbumID};
    [NTGSendRequest getPhotoFromPhotoAlbum:dict success:result];


}
-(void)setPhotoArray:(NSMutableArray *)photoArray{
    if (photoArray != nil) {
        _photoArray = photoArray;
//        for (NTGMemberPhoto *photo in self.photoArray) {
//            photo.tag = NO;
//        }
        
        [self.photoCollectionView reloadData];
    }


}

//编辑相册
-(void)editPhotoAlbumAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    NTGEditPhotoAlbumViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"editPhotoAblum"];
    editVC.photoAlbum = self.photoAlbum;
    editVC.name = self.nameLabel.text;
    editVC.desc = self.descLabel.text;
    editVC.editPhotoAlbum = ^(NSString *name,NSString *desc){
        self.nameLabel.text = name;
        self.descLabel.text = desc;
        [self updateViewConstraints];
    
    };
    [self.navigationController pushViewController:editVC animated:YES];
    [self.editView removeFromSuperview];



}


-(void)deletePhotoAction{
    
    self.isDelete = YES;
    self.uploadBtn.hidden = YES;
    [self.manageBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.editView removeFromSuperview];
    [self.photoCollectionView reloadData];
    


}

-(void)removeView:(UITapGestureRecognizer *)tap{
    
    [self.editView removeFromSuperview];


}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoArray = [NSMutableArray array];
    [self initData];
    self.isDelete = NO;
    
    // Do any additional setup after loading the view.
    self.nameLabel.text = self.photoAlbum.name;
    self.descLabel.text = self.photoAlbum.descript ;
    self.createDateLabel.text = [self dateFromString:self.photoAlbum.createDate];
    
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    
    self.scrollView.contentSize = CGSizeMake(0, 2000);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 5;
    CGFloat widht = (WIDTH - 52) /4.0;
    layout.itemSize = CGSizeMake(widht, widht);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
    layout.headerReferenceSize = CGSizeMake(10, 10);
    layout.footerReferenceSize = CGSizeMake(10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.photoCollectionView.collectionViewLayout = layout;
   
    
}

-(NSString *)dateFromString:(NSString *)string{
    NSString*time = string;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    return confromTimespStr;
    
}

//上传图片
- (IBAction)uploadImgAction:(id)sender {
    //相册
    if (![cameraHelper checkPhotoLibraryAuthorizationStatus]) {
        return;
    }
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    [imagePickerController.selectedAssetURLs removeAllObjects];
    imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    imagePickerController.delegate = self;
    imagePickerController.maximumNumberOfSelection = kupdateMaximumNumberOfImage;
    imagePickerController.allowsMultipleSelection = YES;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}


#pragma mark UINavigationControllerDelegate, QBImagePickerControllerDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.photoArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NTGPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[NTGPhotoCollectionViewCell alloc] init];
    }
    cell.photo = self.photoArray[indexPath.row];
    if (self.isDelete) {
        cell.photoSelectBTn.hidden = NO;
        cell.photoSelectBTn.selected = NO;
        
    }else{
        cell.photoSelectBTn.hidden = YES;
    }
    
    return cell;
 
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isDelete) {
        
    
        NTGPhotoCollectionViewCell *cell =(NTGPhotoCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
        cell.photoSelectBTn.selected = !cell.photoSelectBTn.selected;
       // cell.selectImgV.hidden = !cell.selectImgV.hidden;
        NTGMemberPhoto *photo = self.photoArray[indexPath.row];
        photo.tag = cell.photoSelectBTn.selected;
        NSLog(@"tag == %d",photo.tag);
        
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
        NTGShowPicDetailVC *showPicVC= [storyboard instantiateViewControllerWithIdentifier:@"showPicDetail"];
        showPicVC.photoAlbum = self.photoArray;
        showPicVC.index = indexPath.row;
        
        [self.navigationController pushViewController:showPicVC animated:NO];
    
    }
}


/** 获取选中的文章的ID */
- (NSString *)getAllSelectArticleIds {
    NSString *cid = @"";
    self.articleIDArray = [NSMutableArray array];
    for (int j = 0; j < self.photoArray.count; j++) {
        NTGMemberPhoto *article = self.photoArray[j];
        if (article.tag) {
            cid = [cid stringByAppendingString:[NSString stringWithFormat:@"%ld", article.id]];
            [self.articleIDArray addObject:cid];
            
            cid = [cid stringByAppendingString:@","];
        }
    }
    return cid;
}



//系统方法更新视图
-(void)updateViewConstraints{
    [super updateViewConstraints];
    CGSize size  = [self.nameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.nameViewHeight.constant = size.height + 52;
    
    CGSize size2  = [self.descLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.photoViewHeight.constant = size2.height  +  12;


}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickerImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:[pickerImage CGImage] orientation:(ALAssetOrientation)pickerImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        
        //局部刷新 根据布局相应调整
    }];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UINavigationControllerDelegate, QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets{
    NSMutableArray *selectedAssetURLs = [NSMutableArray new];
    [imagePickerController.selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedAssetURLs addObject:obj];
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",assets);
        
        self.imageMutableArray = [NSMutableArray array];
        [_imageMutableArray removeAllObjects];
        for (ALAsset * asset in assets) {
            
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            CGImageRef imgRef = [assetRep fullResolutionImage];   //获取高清图片
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
            CGImageRef ref = [asset thumbnail];    //获取缩略图
            UIImage *thumbnailImg = [[UIImage alloc]initWithCGImage:ref];
            
            thumbnailImg = img;
            //对图片大小进行压缩--
            CGSize imagesize = img.size;
            imagesize.height =300;
            imagesize.width =300;

            thumbnailImg = [thumbnailImg imageByScalingAndCroppingForSize:imagesize];
            NSData *data;
            if (UIImagePNGRepresentation(thumbnailImg) == nil)
            {
                data = UIImageJPEGRepresentation(thumbnailImg, 0.2);
            }
            else
            {
                data = UIImagePNGRepresentation(thumbnailImg);
            }

            [_imageMutableArray addObject:data];
        }
        
        [self uploadImgRequest:_imageMutableArray];
    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.curUploadImageHelper.selectedAssetURLs = selectedAssetURLs;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //局部刷新 根据布局相应调整
//        });
//    });
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadImgRequest:(NSArray *)imgArray{

    [self addHudWithMessage:@"正在上传"];
    // 上传 多张图片
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(NSInteger i = 0; i < self.imageMutableArray.count; i++) {
        // 上传的参数名
        NSData *data = self.imageMutableArray[i];
        
//        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents%ld",i]];
        
        //上边被注释掉的部分是为了每张图片见一个文件夹用来区分图片，所有的图片都采用同样的名字image.png,这在模拟器上上传没问题，但是在真机上则不行了，于是改变思路，把照片放在同一个文件夹下，但是每张图片的名字都不一样，这样做就能解决这个问题了
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/image%li.png",(long)i]] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@/image%li.png",DocumentsPath, (long)i];
        
        
        [dict setObject:filePath forKey:[NSString stringWithFormat:@"memberPhotols[%ld].file",(long)i]];
        
        

    }
    
    NTGBusinessResult *result = [[NTGBusinessResult alloc] initWithNavController:self.navigationController];
    
    result.onSuccess = ^(id object){
        [self removeHud];
        [self initData];
    };
    result.onFail = ^(id object){
        [self removeHud];
        
    };
    NSDictionary *params = @{@"id":[NSString stringWithFormat:@"%ld",self.photoAlbum.id],@"fileType":@"image"};
    [NTGSendRequest savePhoto:params multipartFormData:dict success:result];
    
    
    
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
