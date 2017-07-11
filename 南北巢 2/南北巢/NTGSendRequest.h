/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGBusinessResult.h"
typedef void(^BusinessResultBlock)(id responseObject);
//typedef void(^BusinessErrorBlock)(NSError *error);

/**
 * control - 业务请求帮助类 
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGSendRequest : NSObject

/** 根据广告位获取广告 */
+ (void)getAdWithPosition:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 查询养老机构列表 :返回机构页和机构过滤条件 */
+ (void)getWrapperInstitutionAttrList:(NSDictionary *)params requestAddr:(NSString*) requestAddr  successBack:(BusinessResultBlock) sb;

/** 养老机构详情 */
+ (void)getInstitutionDetail:(NSDictionary *)params requestAddr:(NSString*) requestAddr successBack:(BusinessResultBlock) sb;

/** 用户评论 */
+ (void)getReviewLevel:(NSDictionary *)params successBack:(BusinessResultBlock) sb;

/** 用户评论内容列表 */
+ (void)reviewList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 根据热卖位查询热卖机构列表 */
+ (void)getHotSaleInstitutionList:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 热门城市 */
+ (void)getHotCity:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 如家养老 ： 根据用户的IP等自动查询养老机构  */
+ (void)getRujia:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 根据精选位查询精选商品、机构列表 */
+ (void)getSelectProductSellerList:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 商品详情 */
+ (void)getProductDetail:(NSDictionary *)params requestAddr:(NSString *) requestAddr successBack:(BusinessResultBlock) sb;

/** 添加收藏 */
+ (void)favoriteAdd:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 选择规格值 */
+ (void)selectSpecificationValue:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 收藏列表 */
+ (void)favoriteList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 删除收藏 */
+ (void)favoriteDelete:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 商品随机推荐 */
+ (void)getProductRandom:(NSDictionary *)params successBack:(BusinessResultBlock) sb;

/** 加入购物车 */
+ (void)getAddCart:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 删除购物车 */
+ (void)getDeleteCart:(NSDictionary *)params success:(BusinessResultBlock)sb;

/** 编辑购物车 */
+ (void)getEditCart:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 购物车列表 */
+ (void)getCartList:(NSDictionary *)params success:(BusinessResultBlock)sb;

/**	确认老年用品订单 */
+ (void)getOrderInfo:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/**	提交订单 */
+ (void)getOrderCreate:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/**	信用卡支持列表 */
+ (void)getBankCardList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 查询老年旅游商品 */
+ (void)getOldTravel:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb;

/** 旅游详情网络请求 */
+ (void)getTripDetail:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock)sb;

/** 路线促销价格（周一至周日) */
+ (void)tripPrices:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 旅游路线总价网络请求 */
+ (void)getTripAmount:(NSDictionary *)params success:(BusinessResultBlock)sb;

/** 老年用品网络请求 */
+ (void)getOldMall:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb;

/** 老年地产网络请求 */
+ (void)getElderlyEstate:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb;

/** 养老保险网络请求 */
+ (void)getInsurance:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb;

/** 养老保险详情 */
+ (void)insuranceContent:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(NTGBusinessResult *)sb;

/** 养老金融 */
+ (void)elderlyFinanceList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 查询分类导航 */
+ (void)getCategoryNavigation:(NSDictionary *)params success:(BusinessResultBlock) sb ;

/** 获取公钥网络请求 */
+ (void)getPublicKey:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 登陆接口网路请求 */
+ (void) login:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 用户注销 */
+ (void) loginOut:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 查询巢友指南数据 */
+ (void)getGuide:(NSDictionary *)params success:(BusinessResultBlock)sb;

/** 巢友指南详情 */
+ (void)nestguideContent:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(NTGBusinessResult *)sb;

/** 查询巢友帮数据 */
+ (void) getJunto:(NSDictionary *)params success:(BusinessResultBlock) sb;

/** 查询巢友帮感悟详情 */
+ (void) getJuntoDetail:(NSDictionary *)params success:(NTGBusinessResult *) sb;


/** 获取会员图片列表 */
+ (void) getMemberPhotoList:(NSDictionary *)params success:(NTGBusinessResult *) sb;
/** 创建相册 */
+(void)createPhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 删除相册 */
+(void)deletePhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb;


/** 更改相册 */
+(void)updatePhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb;
/** 删除图片 */
+(void)deletePhotos:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 获取相册中的图片 */
+(void)getPhotoFromPhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 保存相册照片 */
/** 用户头像 */
+ (void)savePhoto:(NSDictionary *)params multipartFormData:(NSDictionary *)multipartFormData success:(NTGBusinessResult *)sb;






/** 查询会员文章分类 */
+ (void) getMemberArticleCategory:(NSDictionary *)params success:(NTGBusinessResult *) sb;

/** 获取会员文章列表 */
+ (void) getMemberArticleList:(NSDictionary *)params success:(NTGBusinessResult *) sb;

/** 删除会员文章 */
+ (void) deleteArticle:(NSDictionary *)params success:(NTGBusinessResult *) sb;

/** 会员文章详情 */
+(void) getMemBerArticleDetail:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 增加会员文章 */
+(void) saveMemBerArticle:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 编辑会员文章 */
+(void) editMemBerArticle:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 保存文章评论回复 */
+(void) saveCommentReply:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/**对照片，文章，商品  点赞 */
+ (void)savePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/**不登录对照片，文章，商品 点赞 */
+ (void)noLoginSavePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb;
/**不登录取消对照片，文章，商品 点赞 */
+ (void)noLoginCanclePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/**对照片，文章，商品 评论 */
+ (void)saveComment:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 我的评价列表 */
+ (void)getReviewList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 查看评价 */
+ (void)getReviewView:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 我要评价 */
+ (void)getReviewSave:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 我的资料 */
+ (void)getProfile:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 订单列表 */
+ (void)orderList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 订单详情 */
+ (void)orderView:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 取消订单 */
+ (void)orderCancel:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 删除订单 */
+ (void)orderDelete:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 收货地址列表 */
+ (void)getReceiverList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 获取城市列表 */
+ (void)getAreaList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 保存收货地址 */
+ (void)saveReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 编辑收货地址*/
+ (void)editReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 删除收货地址 */
+ (void)deleteReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 根据接收者ID查询地址 */
+ (void)getReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 用户头像 */
+ (void)getUpdateMemberHead:(NSDictionary *)params multipartFormData:(NSDictionary *)multipartFormData success:(NTGBusinessResult *)sb;

/** 更新用户资料 */
+ (void)getUpdateMember:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 发送短信验证码 */
+ (void)getSMSValidCode:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 修改验证手机 */
+ (void)getUpdateMobile:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 修改密码 */
+ (void)getUpdatePassword:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 注册 */
+ (void)registerSubmit:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 校验用户是否已存在 */
+ (void)registerCheck_mobile:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 找回密码 */
+ (void)findPassword:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 获取版本信息 */
+ (void)getVersion:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 分销商列表 */
+ (void)supplierList:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 分销商详情 */
+ (void)supplierContent:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 生成组合收款单 */
+ (void) getPaymentGroup:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 微信支付 */
+ (void) wechatPay:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 支付宝支付 */
+ (void) aliPay:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 综合分类搜索 */
+ (void)integrationSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 首页机构搜索 */
+ (void)institutionSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 首页跟团游搜索 */
+ (void) tripSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 首页保健用品搜索 */
+ (void)productSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 计算客房订单 */
+ (void)roomOrderCalculate:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 提交客房订单 */
+ (void)createRoomOrder:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 提交旅游订单 */
+ (void)createTripOrder:(NSDictionary *)params success:(NTGBusinessResult *)sb;

/** 新版综合分类搜索 */
+ (void)newIntegrationSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb;

@end
