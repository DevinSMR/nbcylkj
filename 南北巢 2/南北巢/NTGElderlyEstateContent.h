/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGArea.h"
#import "NTGProductContent.h"

/**
 * Entity -  养老地产
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGElderlyEstateContent : NSObject

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage2;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage3;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage4;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage5;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage6;

/** 项目图片 */
@property(nonatomic,copy) NSString *projectImage7;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc2;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc3;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc4;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc5;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc6;

/** 项目图片说明 */
@property(nonatomic,copy) NSString *projectImageDesc7;

/** 项目名称 */
@property(nonatomic,copy) NSString *projectName;

/** 所在区域 */
@property(nonatomic,strong) NTGArea *area;

/** 地址 */
@property(nonatomic,copy) NSString *projectAddress;

/** 均价 */
@property(nonatomic,copy) NSString *averagePrice;

/** 咨询热线 */
@property(nonatomic,copy) NSString *hotLine;

/** 咨询热线转 */
@property(nonatomic,copy) NSString *hotLineTurn;

/** 地产ID */
@property(nonatomic,copy) NSString *id;

/** 地址 */
@property(nonatomic,copy) NSString *path;

/** 周边介绍图片1 */
@property(nonatomic,copy) NSString *aroundIntroductionImage1;

/** 周边介绍图片1 */
@property(nonatomic,copy) NSString *aroundIntroductionImage2;

/** 周边介绍图片1 */
@property(nonatomic,copy) NSString *aroundIntroductionImage3;

/** 周边介绍图片1 */
@property(nonatomic,copy) NSString *aroundIntroductionImage4;

/** 周边介绍图片描述 1 */
@property(nonatomic,copy) NSString *aroundIntroductionImageDesc1;

/** 周边介绍图片描述 2 */
@property(nonatomic,copy) NSString *aroundIntroductionImageDesc2;

/** 周边介绍图片描述 3 */
@property(nonatomic,copy) NSString *aroundIntroductionImageDesc3;

/** 周边介绍图片描述 4 */
@property(nonatomic,copy) NSString *aroundIntroductionImageDesc4;

/** 设施图片1 */
@property(nonatomic,copy) NSString *facilityImage1;

/** 设施图片1 */
@property(nonatomic,copy) NSString *facilityImage2;

/** 设施图片1 */
@property(nonatomic,copy) NSString *facilityImage3;

/** 设施图片1 */
@property(nonatomic,copy) NSString *facilityImage4;

/** 设施图片1 */
@property(nonatomic,copy) NSString *facilityImage5;

/** 设施图片描述 1 */
@property(nonatomic,copy) NSString *facilityImageDesc1;

/** 设施图片描述 2 */
@property(nonatomic,copy) NSString *facilityImageDesc2;

/** 设施图片描述 3 */
@property(nonatomic,copy) NSString *facilityImageDesc3;

@property(nonatomic,copy) NSString *facilityImageDesc4;

/** 设施图片描述 5 */
@property(nonatomic,copy) NSString *facilityImageDesc5;

/** 交通地图 */
@property(nonatomic,copy) NSString *trafficMap;

/** 位置地图 */
@property(nonatomic,copy) NSString *positionMap;

/** 户型 */
@property(nonatomic,strong) NSArray *roomTypeProduct;

/** 公交线路 */
@property(nonatomic,copy) NSString *busLine;

/** 公交线路 去html标签 */
@property(nonatomic,copy) NSString *busLineText;

/** 自驾线路 */
@property(nonatomic,copy) NSString *drivingLine;

/** 自驾线路 去html标签 */
@property(nonatomic,copy) NSString *drivingLineText;

/** 概述 */
@property(nonatomic,copy) NSString *introduction;

/** 周边介绍 */
@property(nonatomic,copy) NSString *aroundIntroduction;

/** 设施介绍 */
@property(nonatomic,copy) NSString *facilityIntroduction;

/** 概述文字 */
@property(nonatomic,copy) NSString *introductionText;

/** 周边介绍文字 */
@property(nonatomic,copy) NSString *aroundIntroductionText;

/** 设施介绍 */
@property(nonatomic,copy) NSString *facilityIntroductionText;


@end
