/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 养老景区管理
 *
 * @author 许芳源
 * @version 2014-11-24 新建</br>
 *
 */
@interface NTGScenicRegion : NSObject

/** id */
@property(nonatomic,assign) long id;

/** 景区名称 */
@property(nonatomic,copy) NSString *name;

/** 景区介绍 */
@property(nonatomic,copy) NSString *introduction;

/** 交通信息 */
@property(nonatomic,copy) NSString *trafficInfo;

/** 门票信息 */
@property(nonatomic,copy) NSString *ticketInfo;

/** 位置地图  */
@property(nonatomic,copy) NSString *scenicRegionMap;

/** 焦点图 */
@property(nonatomic,copy) NSString *scenicRegionFocusImage;
/** 焦点图2 */
@property(nonatomic,copy) NSString *scenicRegionFocusImage2;
/** 焦点图3 */
@property(nonatomic,copy) NSString *scenicRegionFocusImage3;

/** 焦点图描述 */
@property(nonatomic,copy) NSString *scenicRegionFocusImageDesc;
/** 焦点图描述2 */
@property(nonatomic,copy) NSString *scenicRegionFocusImageDesc2;
/** 焦点图描述3 */
@property(nonatomic,copy) NSString *scenicRegionFocusImageDesc3;

/** 景区图片1 */
@property(nonatomic,copy) NSString *scenicRegionImage1;

/** 景区图片描述 1*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc1;

/** 景区图片2 */
@property(nonatomic,copy) NSString *scenicRegionImage2;

/** 景区图片描述 2*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc2;

/** 景区图片3 */
@property(nonatomic,copy) NSString *scenicRegionImage3;

/** 景区图片描述 3*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc3;

/** 景区图片4 */
@property(nonatomic,copy) NSString *scenicRegionImage4;

/** 景区图片描述 4*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc4;

/** 景区图片5 */
@property(nonatomic,copy) NSString *scenicRegionImage5;

/** 景区图片描述 5*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc5;

/** 景区图片6 */
@property(nonatomic,copy) NSString *scenicRegionImage6;

/** 景区图片描述6*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc6;

/** 景区图片7 */
@property(nonatomic,copy) NSString *scenicRegionImage7;

/** 景区图片描述 7*/
@property(nonatomic,copy) NSString *scenicRegionImageDesc7;

@property(nonatomic,copy) NSString *path;

/** 景区介绍文字 */
@property(nonatomic,copy) NSString *introductionText;


@end
