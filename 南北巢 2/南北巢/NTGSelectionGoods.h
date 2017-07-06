/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
#import "NTGSeller.h"
#import "NTGElderlyEstateContent.h"
#import "NTGInsuranceContent.h"

/**
 * Entity - 精选商品、机构
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGSelectionGoods : NSObject

/** 养老用品 */
@property(nonatomic,strong) NSArray *products;
//private List<ProductContentBean> products;

/** 机构 */
@property(nonatomic,strong) NSArray *sellers;
//private List<SellerBean> sellers;

/** 老年游 */
@property(nonatomic,strong) NSArray *trips;
//private List<TripContentBean> trips;

/** 养老地产 */
@property(nonatomic,strong) NSArray *elderlyEstates;
//private List<ElderlyEstateContentBean> elderlyEstates;

/** 养老保险 */
@property(nonatomic,strong) NSArray *insurances;
//private List<InsuranceContentBean> insurances;
@end
