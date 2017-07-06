/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"
#import <UIKit/UIKit.h>

/**
 * Entity - 个人中心 相册
 *
 * @author wangwei
 * @version 1.0
 */
@interface NTGMemberPhotoAlbum : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 相册名称 */
@property(nonatomic,copy) NSString *name;

/** 相册描述 */
@property(nonatomic,copy) NSString *descript;

/** 封面照片地址 */
@property(nonatomic,copy) NSString *coverPath;

/** 会员 */
@property(nonatomic,strong) NTGMember *member;

/** 图片列表 */
@property(nonatomic,strong) NSArray *memberPhotos;

/** 创建日期 */
@property(nonatomic,copy) NSString *createDate;

@property (nonatomic,assign) CGFloat cellHeight;
@end;
