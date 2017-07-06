/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
#import "NTGArea.h"

/**
 * Entity - 旅游商品
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGTripContent : NSObject

/** 商品主表信息 */
@property(nonatomic,strong) NTGProductContent *product;

/** 出发地 */
@property(nonatomic,strong) NTGArea *startAreaId;

/** 目的地 */
@property(nonatomic,strong) NTGArea *endAreaId;

/** 旅游天数 */
@property(nonatomic,copy) NSString *tripdays;

/** 起步价 */
@property(nonatomic,copy) NSString *startPrice;

/** 旅游名称 */
@property(nonatomic,copy) NSString *name;

/** 旅游路径 */
@property(nonatomic,copy) NSString *path;

/** 线路说明 */
@property(nonatomic,copy) NSString *descr;

/** 行程概要 */
@property(nonatomic,strong) NSArray *tripSummary;
//private List<TripSummaryBean> tripSummary;

/** 行程介绍 */
@property(nonatomic,copy) NSString *introduction;

/** 费用信息 */
@property(nonatomic,copy) NSString *costInfo;

/** 预定须知 */
@property(nonatomic,copy) NSString *scheduledNotes;

/** 路线单价 */
@property(nonatomic,copy) NSString *price;
@end
