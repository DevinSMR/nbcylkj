//
//  NTGPhotoListCell.m
//  南北巢
//
//  Created by nbc on 16/7/18.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import "NTGPhotoListCell.h"
#import <UIImageView+WebCache.h>
#import "NTGMemberPhoto.h"
@interface NTGPhotoListCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///图片容器
@property (weak, nonatomic) IBOutlet UIView *picContentView;

@end
@implementation NTGPhotoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{

    [super layoutSubviews];
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.nameLabel addGestureRecognizer:tap];
    self.nameLabel.userInteractionEnabled = YES;
        self.nameLabel.text = self.photoAlbum.name;
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoAlbum)];
    [self.picContentView addGestureRecognizer:pan];

        if (self.photoAlbum.memberPhotos.count > 0) {
            CGFloat Wide = [UIScreen mainScreen].bounds.size.width;
            CGFloat photoWide = (Wide - 52 - 64) / 3.0;
            NSInteger photoRowNumb = 0;
            if (self.photoAlbum.memberPhotos.count % 3 == 0) {
                photoRowNumb = self.photoAlbum.memberPhotos.count/3;
            }else{
                photoRowNumb = self.photoAlbum.memberPhotos.count/3 + 1;
                
            }
            UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoAlbum)];
            [self.picContentView addGestureRecognizer:pan];
            for (int i = 0 ; i < photoRowNumb; i++) {
                for (int j = 0; j < 3; j++) {
                    if (i * 3 + j < self.photoAlbum.memberPhotos.count) {
                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(j * (photoWide + 10), 10 + i * (photoWide + 10), photoWide, photoWide)];
                        NTGMemberPhoto *photo = self.photoAlbum.memberPhotos[i * 3 + j];
                        imgView.image = nil;
                        [imgView sd_setImageWithURL:[NSURL URLWithString:photo.path] placeholderImage:[UIImage imageNamed:@"pictureReplace"]];
                        imgView.backgroundColor = [UIColor redColor];
                        [imgView addGestureRecognizer:pan];
                        [self.picContentView addSubview:imgView];
                    }
                }
                
            }
            
        }
        NSString *creatDate =[self dateFromString:self.photoAlbum.createDate];
        NSString *dayTime = [creatDate substringWithRange:NSMakeRange(8, 2)];
        NSString *yearTime = [creatDate substringWithRange:NSMakeRange(0, 7)];
        self.dayLabel.text = dayTime;
        self.yearLabel.text = yearTime;
    
    
    
        
        

}
-(void)setPhotoAlbum:(NTGMemberPhotoAlbum *)photoAlbum{
    if (photoAlbum != nil) {
        _photoAlbum = photoAlbum;
    }
    
    
}
-(void)prepareForReuse{

    [self.picContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];

}
-(NSString *)dateFromString:(NSString *)string{
    NSString*time = string;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    long long t =[time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:t/1000.0];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:SS"];
    NSString*confromTimespStr = [formatter stringFromDate:d];
    return confromTimespStr;
    
}
-(void)showPhotoAlbum{

    [self.cellDelegate pushToPhotoManager:self.photoAlbum];
}

-(void)click:(UILabel *)lable{

    [self.cellDelegate pushToPhotoManager:self.photoAlbum];
}
//删除相册事件
- (IBAction)deleteBtnAction:(UIButton *)sender {
    [self.cellDelegate deletePhotoAlum:self.photoAlbum.id];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
