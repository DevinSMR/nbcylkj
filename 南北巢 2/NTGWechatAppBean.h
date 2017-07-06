//
//  NTGWechatAppBean.h
//  南北巢
//
//  Created by nbc on 16/1/20.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTGWechatAppBean : NSObject
/** 公众账号ID */
@property (nonatomic,copy) NSString *appid;

/** 商户号 */
@property (nonatomic,copy) NSString *partnerid;

/** 预支付交易会话ID */
@property (nonatomic,copy) NSString *prepayid;

/** 扩展字段 */
@property (nonatomic,copy) NSString *packageValue;

/** 随机字符串 */
@property (nonatomic,copy) NSString *noncestr;

/** 时间戳 */
@property (nonatomic,copy) NSString *timestamp;

/** 签名 */
@property (nonatomic,copy) NSString *sign;
@end
