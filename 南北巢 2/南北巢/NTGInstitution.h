/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 机构信息管理
 *
 * @author 谷强
 * @version 2014-10-27 新建</br>
 */
@interface NTGInstitution : NSObject

/** 焦点图 */
@property(nonatomic,copy) NSString *institutionFocusImage;

/** 机构介绍图片1 */
@property(nonatomic,copy) NSString *institutionIntroductionImage1;

/** 机构介绍图片2 */
@property(nonatomic,copy) NSString *institutionIntroductionImage2;

/** 机构介绍图片3 */
@property(nonatomic,copy) NSString *institutionIntroductionImage3;

/** 机构介绍图片4 */
@property(nonatomic,copy) NSString *institutionIntroductionImage4;

/** 机构介绍图片5 */
@property(nonatomic,copy) NSString *institutionIntroductionImage5;

/** 机构介绍图片6 */
@property(nonatomic,copy) NSString *institutionIntroductionImage6;

/** 静态地图 */
@property(nonatomic,copy) NSString *introductionMap;

/** 周边介绍图片1 */
@property(nonatomic,copy) NSString *aroundIntroductionImage1;

/** 周边介绍图片2 */
@property(nonatomic,copy) NSString *aroundIntroductionImage2;

/** 周边介绍图片3 */
@property(nonatomic,copy) NSString *aroundIntroductionImage3;

/** 周边介绍图片4 */
@property(nonatomic,copy) NSString *aroundIntroductionImage4;

@property(nonatomic,copy) NSString *aroundIntroductionText;

@property(nonatomic,copy) NSString *aroundIntroduction;

/** 机构设施图片1 */
@property(nonatomic,copy) NSString *institutionFacilityImage1;

/** 机构设施图片2 */
@property(nonatomic,copy) NSString *institutionFacilityImage2;

/** 机构设施图片3 */
@property(nonatomic,copy) NSString *institutionFacilityImage3;

/** 机构设施图片4 */
@property(nonatomic,copy) NSString *institutionFacilityImage4;

/** 机构设施图片5 */
@property(nonatomic,copy) NSString *institutionFacilityImage5;

/** 机构设施介绍 */
@property(nonatomic,copy) NSString *institutionFacilityDesc;
@property(nonatomic,copy) NSString *institutionFacilityDescText;

/** 机构服务图片1 */
@property(nonatomic,copy) NSString *institutionServiceImage1;

/** 机构服务图片2 */
@property(nonatomic,copy) NSString *institutionServiceImage2;

/** 机构服务图片3 */
@property(nonatomic,copy) NSString *institutionServiceImage3;

/** 机构服务图片4 */
@property(nonatomic,copy) NSString *institutionServiceImage4;

/** 机构服务介绍 */
@property(nonatomic,copy) NSString *institutionServiceText;

/** 公交线路 */
@property(nonatomic,copy) NSString *institutionBusText;

/** 自驾线路 */
@property(nonatomic,copy) NSString *institutionDrivingText;

/** 机构服务介绍 */
@property(nonatomic,copy) NSString *institutionService;

/** 公交线路 */
@property(nonatomic,copy) NSString *institutionBus;

/** 自驾线路 */
@property(nonatomic,copy) NSString *institutionDriving;

/** 价格 */
@property(nonatomic,copy) NSString *startPrice;

@end
