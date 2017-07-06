/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGMember.h"

/**
 * Entity - 联盟会员网站
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGMemberSite : NSObject

/** 联盟会员网站类型 ： 枚举类型，参照已经注释掉的代码 */
@property(nonatomic,copy) NSString *siteType;

/** 网站名称 */
@property(nonatomic,copy) NSString *siteName;

/** 网站域名 */
@property(nonatomic,copy) NSString *siteDomainName;

///** 网站类型 */
//@property(nonatomic,assign) MemberSiteType siteType;

/** 联盟会员 */
@property(nonatomic,strong) NTGMember *member;

/** 联盟投放 */
@property(nonatomic,strong) NSArray *alliancePutIns;

///**
// * 联盟会员网站类型
// */
//public enum MemberSiteType{
//    /** 分享导购站 */
//    shareBuy,
//
//    /** 返利网站 */
//    benefitSite,
//
//    /** 比价购物 */
//    contrastBuy,
//
//    /** 购物搜索 */
//    buySearch,
//
//    /** 商品点评 */
//    productComment,
//
//    /** 消费资讯 */
//    consumeInfo,
//
//    /** 网址导航 */
//    URLnavigation,
//
//    /** 健身美容 */
//    fitnessHairdressing,
//
//    /** 服装时尚 */
//    dressFashion,
//
//    /** 社区交友 */
//    communityPal,
//
//    /** 数码硬件 */
//    figureHardware,
//
//    /** 软件下载*/
//    softDownload,
//
//    /** 语言教育 */
//    languageEducation,
//
//    /** 金融财经 */
//    financial,
//
//    /** 招聘求职 */
//    jobs,
//
//    /** 旅游度假 */
//    trip,
//
//    /** 积分返点 */
//    scorePoint,
//
//    /** 医疗健康 */
//    doctorHealth,
//
//    /** 母婴育儿 */
//    maternalParenting,
//
//    /** 体育运动 */
//    sport,
//
//    /** 影视音乐 */
//    videoMusic,
//
//    /** 文学艺术 */
//    art,
//
//    /** 综合门户 */
//    synthesizePortal,
//
//    /** 地域门户 */
//    territoryPortal,
//
//    /** 客户端 */
//    client,
//
//    /** 个人博客 */
//    personalBlog,
//
//    /** 信息港 */
//    newsHarbor,
//
//    /** 其他 */
//    other,
//
//    /** 优惠券网站 */
//    couponSite,
//
//    /** 浏览器 */
//    broswer
//}

@end
