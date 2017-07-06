/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"

/**
 * Entity -  养老保险
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGInsuranceContent : NSObject

/** 产品信息 */
@property(nonatomic,strong) NTGProductContent *product;

/** 时间限制 */
@property(nonatomic,copy) NSString *timeLimit;

/** 年龄 */
@property(nonatomic,copy) NSString *age;

/** 养老保险介绍 */
@property(nonatomic,copy) NSString *text;

/** 描述 */
@property(nonatomic,copy) NSString *introduction;

/** 阅读条款 */
@property(nonatomic,copy) NSString *clauseIntroduction;

/** 产品说明 */
@property(nonatomic,copy) NSString *productIntroduction;

/** 购买须知 */
@property(nonatomic,copy) NSString *noticeIntroduction;

/** 理赔须知 */
@property(nonatomic,copy) NSString *requireIntroduction;

/** 养老保险路径 */
@property(nonatomic,copy) NSString *path;

/** id */
@property(nonatomic,assign) long id;

@end
