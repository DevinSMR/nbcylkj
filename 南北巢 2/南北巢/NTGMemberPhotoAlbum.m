/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGMemberPhotoAlbum.h"
#import "NTGMemberPhoto.h"
#import <MJExtension.h>
/**
 * Entity - 个人中心 相册
 *
 * @author wangwei
 * @version 1.0
 */
@implementation NTGMemberPhotoAlbum

+ (NSDictionary *)objectClassInArray{
    return @{
             @"memberPhotos":[NTGMemberPhoto class]
            };
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             
             @"descript" : @"description",
             };
}
-(CGFloat)cellHeight{
    if (self.memberPhotos.count > 0) {
        CGFloat Wide = [UIScreen mainScreen].bounds.size.width;
        CGFloat photoWide = (Wide - Wide / 9.0 - 70) / 3.0;
        if (self.memberPhotos.count % 3 == 0) {
            NSInteger photoRowNumb = self.memberPhotos.count/3;
            _cellHeight = (photoWide + 10) * photoRowNumb + 10  + 64  ;
        }else{
            NSInteger photoRowNumb = self.memberPhotos.count/3 + 1;
            _cellHeight = (photoWide + 10) * photoRowNumb + 10 + 64  ;
        }
        return _cellHeight;
    }else{
    
        return 95;
    }
}
@end
