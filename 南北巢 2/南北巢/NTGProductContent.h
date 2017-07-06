/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductCategory.h"
#import "NTGGuestRoom.h"
//#import "NTGSelectSpecificationValue.h"
#import "NTGSpecificationValueBean.h"
@class NTGSeller;

/**
 * Entity - 商品详情
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:08:42 <br/>
 *
 */
@interface NTGProductContent : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 商品名称 */
@property(nonatomic,copy) NSString *name;

/** 商品全称 */
@property(nonatomic,copy) NSString *fullName;

/** 销售价 */
@property(nonatomic,copy) NSString *price;

/** 市场价 */
@property(nonatomic,copy) NSString *marketPrice;

/** 展示图片 */
@property(nonatomic,copy) NSString *image;

/** 缩略图 */
@property(nonatomic,copy) NSString *thumbnail;

/** 标签 */
@property(nonatomic,strong) NSArray *tags;

/** 商品路径 */
@property(nonatomic,copy) NSString *wrapPath;

/** 路径 */
@property(nonatomic,copy) NSString *path;

/** 商品图片 */
@property(nonatomic,strong) NSArray *productImages;

/** 卖家名称 */
@property(nonatomic,copy) NSString *sellerName;

/** 卖家地址 */
@property(nonatomic,copy) NSString *sellerAddress;

/** 商品介绍 */
@property(nonatomic,copy) NSString *introduction;

/** 商品分类 */
@property(nonatomic,strong) NTGProductCategory *productCategory;

/** 客房 */
@property(nonatomic,strong) NTGGuestRoom *guestRoom;

/** 会员管理 */
@property(nonatomic,strong) NTGSeller *seller;

/** 参数值 */
@property(nonatomic,strong) NSArray * paramValue;

/** 旅游路线或者客房的单价 */
@property(nonatomic,copy) NSString *priceByInstitution;

/** android 使用判断选中状态 :非服务端返回值 */
@property(nonatomic,assign) BOOL flag;

/** 评分数 */
@property(nonatomic,assign) long scoreCount;

/** 月销量 */
@property(nonatomic,assign) long monthSales;

/** 规格 */
@property (nonatomic,strong) NSArray *specificationValues;

/** 商品库存 */
@property(nonatomic,assign) long stock;

/** 已收藏此商品的会员id数组 */
@property (nonatomic,strong) NSArray *favoriteMemberIds;

@end
