/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGArea.h"
#import "NTGInstitution.h"
#import "NTGProductContent.h"

/**
 * Entity - 会员管理
 *
 * @author 许芳源
 * @version 2014-10-17 新建</br>
 *
 */
@interface NTGSeller : NSObject

/** 机构唯一标识 */
@property(nonatomic,copy) NSString *id;

/** 地区 */
@property(nonatomic,strong)  NTGArea *area;

/** 机构概述 */
@property(nonatomic,copy) NSString *text;

/** 会员名称 */
@property(nonatomic,copy) NSString *name;

/** 会员地址 */
@property(nonatomic,copy) NSString *address;

/** 机构介绍 */
@property(nonatomic,copy) NSString *introduction;

/** 机构会员管理 */
@property(nonatomic,strong) NTGInstitution *institution;

/** 评分数 */
@property(nonatomic,assign) long scoreCount;

/** 总评分 */
@property(nonatomic,assign) long totalScore;

/** 路径 */
@property(nonatomic,copy) NSString *path;

/** 会员星级 */
@property(nonatomic,assign) long starLevelId;

/** 是否显示 */
@property(nonatomic,getter=isShow) BOOL isShow;

@property(nonatomic,strong) NSArray *products;

@end
