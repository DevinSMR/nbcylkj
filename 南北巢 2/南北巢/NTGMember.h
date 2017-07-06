/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 会员
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGMember : NSObject <NSCoding>

/** id */
@property(nonatomic,assign) long id;

/** E-mail */
@property(nonatomic,copy) NSString *email;

/** 姓名 */
@property(nonatomic,copy) NSString *name;

/** 性别 */
@property(nonatomic,copy) NSString *gender;

/** 出生日期 */
@property(nonatomic,assign) long birth;

/** 手机 */
@property(nonatomic,copy) NSString *mobile;

/** 手机 */
@property(nonatomic,copy) NSString *phone;

/**昵称*/
@property(nonatomic,copy) NSString *petName;

/**头像原图*/
@property(nonatomic,copy) NSString *picture;

/**收货地址*/
@property(nonatomic,strong) NSArray *receivers;

/**头像小图*/
@property(nonatomic,copy) NSString *picture2;

/** 用户名 */
@property(nonatomic,copy) NSString *username;

/** 平台类型 */
@property(nonatomic,copy) NSString *platformType;

/** "用户id" 名称 */
@property(nonatomic,copy) NSString *userid;

/** "头像" 原图 */
@property(nonatomic,copy) NSString *pictureOrg;

/** "头像" 中图 */
@property(nonatomic,copy) NSString *pictureMid;

/** "头像" 小图 */
@property(nonatomic,copy) NSString *pictureSml;

//private PlatformType platformType;

/**
 * 会员平台类型
 */
//public enum PlatformType{
//
//    /** 一般用户 */
//    normal,
//
//    /** 联盟用户 */
//    union,
//
//    /** 供应商 */
//    supplier
//}
@end
