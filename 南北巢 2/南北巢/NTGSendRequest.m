/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSendRequest.h"
#import "NTGNetworkTool.h"
#import <MJExtension.h>
#import "NTGAd.h"
#import "NTGAdPosition.h"
#import "NTGPage.h"
#import "NTGSeller.h"
#import "NTGProductSellerAttrWrapper.h"
#import "NTGHotSalePosition.h"
#import "NTGCategoryNavigation.h"
#import "NTGSelectionGoods.h"
#import "NTGTripContent.h"
#import "NTGProductContent.h"
#import "NTGElderlyEstateContent.h"
#import "NTGInsuranceContainer.h"
#import "NTGMember.h"
#import "NTGHotCity.h"
#import "NTGReviewLevel.h"
#import "NTGProductContainer.h"
#import "NTGElderlyEstateContent.h"
#import "NTGMemberArticle.h"
#import "NTGScenicRegionContent.h"
#import "NTGScenicRegionPage.h"
#import "NTGHotCitypage.h"
#import "NTGProductPage.h"
#import "NTGCart.h"
#import "NTGBusinessResult.h"
#import "NTGOrderItem.h"
#import "NTGAppVersion.h"
#import "NTGOrderInfo.h"
#import "NTGReceiverContent.h"
#import "NTGAttribute.h"
#import "NTGSupplier.h"
#import "NTGOrderContent.h"
#import "NTGReviewContent.h"
#import "NTGAlipayAppBean.h"
#import "NTGWechatAppBean.h"
#import "NTGMemberComment.h"
#import "NTGFinance.h"
#import "NTGReviewContent.h"
#import "NTGMemberArticleDetail.h"
#import "CalendarPrices.h"
#import "NTGIntegration.h"
#import "NTGSelectSpecificationValue.h"
#import "NTGDetection.h"
#import "NTGMBProgressHUD.h"
#import "NTGMemberPhotoAlbum.h"
#import "NTGIntegrationSearch.h"
#import "NTGIntegrationSearch.h"
#import "NTGProductResult.h"
#import <UIKit/UIKit.h>
/**
 * control - 业务请求帮助类
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGSendRequest

/** 根据广告位获取广告 */
+ (void)getAdWithPosition:(NSDictionary *)params success:(BusinessResultBlock)sb  {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        
        NTGAdPosition * adPosition = [NTGAdPosition objectWithKeyValues : responseObject];
        sb(adPosition);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/adPosition/list.jhtml" params:params result:s error:nil];
}

/** 查询养老机构 */
+ (void)getWrapperInstitutionAttrList:(NSDictionary *)params requestAddr:(NSString*) requestAddr successBack:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGSeller class]
                     };
        }];
        
        NTGProductSellerAttrWrapper *institutions = [NTGProductSellerAttrWrapper objectWithKeyValues:responseObject]; 
        sb(institutions);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 机构详情 */
+ (void)getInstitutionDetail:(NSDictionary *)params requestAddr:(NSString *) requestAddr successBack:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGSeller *seller = [NTGSeller objectWithKeyValues:responseObject];
        sb(seller);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
    
}

/** 用户评论条数 */
+ (void)getReviewLevel:(NSDictionary *)params successBack:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGReviewLevel *level = [NTGReviewLevel objectWithKeyValues:responseObject];
        sb(level);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/review/reviewCount.jhtml" params:params result:s error:nil];
}

/** 用户评论内容列表 */
+ (void)reviewList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGReviewContent class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/review/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 如家养老 */
+ (void)getRujia:(NSDictionary *)params success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray *rj = [NTGSeller objectArrayWithKeyValuesArray:responseObject];
        sb(rj);

    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/elderlyHomeInn/index.jhtml" params:params result:s error:nil];
}

/** 南北养老 */
+ (void)getHotSaleInstitutionList:(NSDictionary *)params success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGHotSalePosition *hsm = [NTGHotSalePosition objectWithKeyValues:responseObject];
        sb(hsm);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/hotSalePosition/list.jhtml" params:params result:s error:nil];
}


/** 热门城市 */
+ (void)getHotCity:(NSDictionary *)params success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGHotCitypage *hsm = [NTGHotCitypage objectWithKeyValues:responseObject];
        sb(hsm);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/hotCity/list.jhtml" params:params result:s error:nil];
}

/** 根据精选位查询热卖商品、机构列表 */
+ (void)getSelectProductSellerList:(NSDictionary *)params success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGSelectionGoods *s = [NTGSelectionGoods objectWithKeyValues:responseObject];
        sb(s);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/selectionPosition/list.jhtml" params:params result:s error:nil];
}

/** 商品详情 */
+ (void)getProductDetail:(NSDictionary *)params requestAddr:(NSString *) requestAddr successBack:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGProductContainer *product = [NTGProductContainer objectWithKeyValues:responseObject];
        sb(product);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 添加收藏 */
+ (void)favoriteAdd:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/favorite/add.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 选择规格值 */
+ (void)selectSpecificationValue:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGSelectSpecificationValue *selectSpecificationValue = [NTGSelectSpecificationValue objectWithKeyValues:responseObject];
        sb.onSuccess(selectSpecificationValue);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/product/selectSpecificationValue.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 收藏列表 */
+ (void)favoriteList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGProductContent class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/favorite/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 删除收藏 */
+ (void)favoriteDelete:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/favorite/delete.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 商品随机推荐 */
+ (void)getProductRandom:(NSDictionary *)params successBack:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGProductPage *hsm = [NTGProductPage objectWithKeyValues:responseObject];
        sb(hsm);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/product/productRandom.jhtml" params:params result:s error:nil];
}

/** 加入购物车 */
+ (void)getAddCart:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
        sb.onSuccess(quantity);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/cart/add.jhtml" params:params innerSuccessWrapper:s result:sb];
}

//+ (void)getAddCart:(NSDictionary *)params success:(BusinessResultBlock)sb {
//    
//    void(^s)(id responseObject) = ^(id responseObject) {
//        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
//        sb(quantity);
//    };
//    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/cart/add.jhtml" params:params result:s error:nil];
//}

/** 删除购物车 */
+ (void)getDeleteCart:(NSDictionary *)params success:(BusinessResultBlock)sb {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
        sb(quantity);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/cart/delete.jhtml" params:params result:s error:nil];
}

/** 编辑购物车 */
+ (void)getEditCart:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
        sb.onSuccess(quantity);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/cart/edit.jhtml" params:params innerSuccessWrapper:s result:sb];
}

//+ (void)getEditCart:(NSDictionary *)params success:(BusinessResultBlock)sb {
//    
//    void(^s)(id responseObject) = ^(id responseObject) {
//        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
//        sb(quantity);
//    };
//    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/cart/edit.jhtml" params:params result:s error:nil];
//}

/** 购物车列表 */
+ (void)getCartList:(NSDictionary *)params success:(BusinessResultBlock)sb {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGCart *quantity = [NTGCart objectWithKeyValues:responseObject];
        sb(quantity);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/cart/list.jhtml" params:params result:s error:nil];
}

/**	确认老年用品订单 */
+ (void)getOrderInfo:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGOrderInfo *orderInfo = [NTGOrderInfo objectWithKeyValues:responseObject];
        sb.onSuccess(orderInfo);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/order/info.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/**	提交订单 */
+ (void)getOrderCreate:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSString *sns = responseObject;
        sb.onSuccess(sns);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/order/create.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/**	信用卡支持列表 */
+ (void)getBankCardList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray *attribute = [NTGAttribute objectArrayWithKeyValuesArray:responseObject];
        sb.onSuccess(attribute);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/payment/bankCardList.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 老年旅游网络请求 */
+ (void)getOldTravel:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGTripContent class]
                     };
        }];
        NTGProductSellerAttrWrapper *product = [NTGProductSellerAttrWrapper objectWithKeyValues:responseObject];
        sb(product);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 旅游详情网络请求 */
+ (void)getTripDetail:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock)sb {
    //发送http请求回调
    void(^s)(id responseObject) = ^(id responseObject) {
        //声明数组元素的对象类型
        NTGTripContent *trip = [NTGTripContent objectWithKeyValues:responseObject];
        sb(trip);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 路线促销价格（周一至周日) */
+ (void)tripPrices:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray * prices = [CalendarPrices objectArrayWithKeyValuesArray:responseObject];
        sb.onSuccess(prices);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/tripOrder/tripPrices.jhtml" params:params innerSuccessWrapper:s result:sb];

}

/** 旅游路线总价网络请求 */
+ (void)getTripAmount:(NSDictionary *)params success:(BusinessResultBlock)sb {
    //发送http请求回调
    void(^s)(id responseObject) = ^(id responseObject) {
        NSNumber * price = responseObject;
        sb(price);
    };;
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/trip/calculate.jhtml" params:params result:s error:nil];
}

/** 老年用品网络请求 */
+ (void)getOldMall:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGProductContent class]
                     };
        }];
        NTGProductSellerAttrWrapper *product = [NTGProductSellerAttrWrapper objectWithKeyValues:responseObject];
        sb(product);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 老年地产网络请求 */
+ (void)getElderlyEstate:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGElderlyEstateContent class]
                     };
        }];
        NTGProductSellerAttrWrapper *product = [NTGProductSellerAttrWrapper objectWithKeyValues:responseObject];
        sb(product);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 养老保险网络请求 */
+ (void)getInsurance:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGInsuranceContent class]
                     };
        }];
        NTGProductSellerAttrWrapper *product = [NTGProductSellerAttrWrapper objectWithKeyValues:responseObject];
        sb(product);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params result:s error:nil];
}

/** 养老保险详情 */
+ (void)insuranceContent:(NSDictionary *)params requestAddr:(NSString *)requestAddr success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGInsuranceContainer * insuranceContainer = [NTGInsuranceContainer objectWithKeyValues:responseObject];
        sb.onSuccess(insuranceContainer);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params innerSuccessWrapper:s result:sb];
}

/** 养老金融 */
+ (void)elderlyFinanceList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGFinance class]
                     };
        }];
        NTGPage * page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/elderlyFinance/list/542.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 分类页面接口网络请求 */
+ (void)getCategoryNavigation:(NSDictionary *)params success:(BusinessResultBlock) sb  {
    //发送http请求回调
    void(^s)(id responseObject) = ^(id responseObject) {
        //声明数组元素的对象类型
        NSArray *r = [NTGCategoryNavigation objectArrayWithKeyValuesArray:responseObject];
        sb(r);
    };

    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/categoryNavigation/categoryNavigation.jhtml" params:params result:s error:nil];
}

/** 获取公钥网络请求 */
+ (void)getPublicKey:(NSDictionary *)params success:(BusinessResultBlock) sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        //声明数组元素的对象类型
        NSString *r =  (NSString *)responseObject;
        sb(r);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/common/publicKey.jhtml" params:params result:s error:nil];

}

/** 登陆接口网路请求 */
+ (void) login:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    //字典转对象
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGMember * member = [NTGMember objectWithKeyValues:responseObject];
        if (member) {
            sb.onSuccess(member);
        }else {
            sb.onFail(responseObject);
        }
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/login/login4Ios.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 查询巢友指南数据 */
+ (void)getGuide:(NSDictionary *)params success:(BusinessResultBlock)sb {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGScenicRegionPage *page = [NTGScenicRegionPage objectWithKeyValues:responseObject];
        sb(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/nestguide/index.jhtml" params:params result:s error:nil];
}

/** 巢友指南详情 */
+ (void)nestguideContent:(NSDictionary *)params requestAddr:(NSString*)requestAddr success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGMemberComment class]
                     };
        }];
        NTGScenicRegionContent *scenicRegionContent = [NTGScenicRegionContent objectWithKeyValues:responseObject];
        sb.onSuccess(scenicRegionContent);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:requestAddr params:params innerSuccessWrapper:s result:sb];
}

/** 查询巢友帮数据 */
+ (void)getJunto:(NSDictionary *)params success:(BusinessResultBlock) sb{
    
     void(^s)(id responseObject) = ^(id responseObject) {
         NSArray *articles = [NTGMemberArticle objectArrayWithKeyValuesArray:responseObject];
         sb(articles);
     };
    
     [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/nestgang/inspiration.jhtml" params:params result:s error:nil];
}

/** 查询巢友帮感悟详情 */
+ (void) getJuntoDetail:(NSDictionary *)params success:(NTGBusinessResult *) sb{
    void(^s)(id object) = ^(id object){
    
        NTGMemberArticleDetail *articleDetail = [NTGMemberArticleDetail objectWithKeyValues:object];
        sb.onSuccess(articleDetail);
    
    };
    
    NSString *detailUrl = params[@"url"];
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:detailUrl params:nil innerSuccessWrapper:s result:sb];

}
#pragma mark --我的图片
/** 获取会员图片列表 */
+ (void) getMemberPhotoList:(NSDictionary *)params success:(NTGBusinessResult *) sb
{
    void(^s)(id responseObject) = ^(id responseObject){
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGMemberPhotoAlbum class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        
        
        sb.onSuccess(page);
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/photoalbum/list.jhtml" params:params innerSuccessWrapper:s result:sb];


}
/** 创建相册 */
+(void)createPhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb{

    
    
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
        
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/photoalbum/save.jhtml" params:params innerSuccessWrapper:s result:sb];
    

}

/** 删除相册 */
+(void)deletePhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb{

    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
        
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/photoalbum/deletePhotoAlbum.jhtml" params:params innerSuccessWrapper:s result:sb];


}

/** 更改相册 */
+(void)updatePhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
        
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/photoalbum/updatePhotoAlbum.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 删除图片 */
+(void)deletePhotos:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
        
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/photo/delete.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 获取相册中的图片 */
+(void)getPhotoFromPhotoAlbum:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject){
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGMemberPhoto class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        
        
        sb.onSuccess(page);
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/privacy/member/homepage/photoList.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 保存相册照片 */
+ (void)savePhoto:(NSDictionary *)params multipartFormData:(NSDictionary *)multipartFormData success:(NTGBusinessResult *)sb{

    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
        
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/photo/savePhoto.jhtml" params:params multipartFormData:multipartFormData innerSuccessWrapper:s result:sb];
}


/** 查询会员文章分类 */
+ (void) getMemberArticleCategory:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    //字典转对象
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray *articlesCategory = [NTGMemberArticleCategory objectArrayWithKeyValuesArray:responseObject];
        
        sb.onSuccess(articlesCategory);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/memberArticleCategory/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}
/** 获取会员文章列表 */
+(void)getMemberArticleList:(NSDictionary *)params success:(NTGBusinessResult *)sb
{
    void(^s)(id responseObject) = ^(id responseObject){
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGMemberArticle class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
      
        
        sb.onSuccess(page);
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/memberArticle/list.jhtml" params:params innerSuccessWrapper:s result:sb];
    
}
/** 会员文章详情 */
+(void)getMemBerArticleDetail:(NSDictionary *)params success:(NTGBusinessResult *)sb
{
    void(^s)(id responseObject) = ^(id responseObject){
        NTGMemberArticleDetail *memberArticleDetail = [NTGMemberArticleDetail objectWithKeyValues:responseObject];
        sb.onSuccess(memberArticleDetail);
    
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/memberArticle/content.jhtml" params:params innerSuccessWrapper:s result:sb];

}


/** 增加会员文章 */
+(void) saveMemBerArticle:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberArticle/save.jhtml" params:params innerSuccessWrapper:s result:sb];
}
/** 编辑会员文章 */
+(void) editMemBerArticle:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberArticle/update.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 保存文章评论回复 */
+(void) saveCommentReply:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberComment/saveArticleCommentReply.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 删除会员文章 */
+ (void) deleteArticle:(NSDictionary *)params success:(NTGBusinessResult *) sb
{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberArticle/delete.jhtml" params:params innerSuccessWrapper:s result:sb];
}


/**对照片，文章，商品 点赞 */
+ (void)savePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGMemberArticleDetail *memberArticleDetail = [NTGMemberArticleDetail objectWithKeyValues:responseObject];
        sb.onSuccess(memberArticleDetail);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/praise/savePraise.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/**不登录对照片，文章，商品 点赞 */
+ (void)noLoginSavePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGMemberArticleDetail *memberArticleDetail = [NTGMemberArticleDetail objectWithKeyValues:responseObject];
        sb.onSuccess(memberArticleDetail);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/praise/savePraise.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/**不登录取消对照片，文章，商品 点赞 */
+ (void)noLoginCanclePraise:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGMemberArticleDetail *memberArticleDetail = [NTGMemberArticleDetail objectWithKeyValues:responseObject];
        sb.onSuccess(memberArticleDetail);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/praise/cancelPraise.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/**对照片，文章，商品 评论 */
+ (void)saveComment:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        //        NTGMemberArticleDetail *memberArticleDetail = [NTGMemberArticleDetail objectWithKeyValues:responseObject];
        sb.onSuccess(responseObject);
    };
    
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberComment/saveComment.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 我的评价列表 */
+ (void)getReviewList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    //字典转对象
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGOrderItem class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/review/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 查看评价 */
+ (void)getReviewView:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    //字典转对象
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGReviewContent *reviewContent = [NTGReviewContent objectWithKeyValues:responseObject];
        sb.onSuccess(reviewContent);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/review/view.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 我要评价 */
+ (void)getReviewSave:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    //字典转对象
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/review/save.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 我的资料 */
+ (void)getProfile:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGMember *member = [NTGMember objectWithKeyValues:responseObject];
        sb.onSuccess(member);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/profile/view.jhtml" params:params innerSuccessWrapper:s result:sb];
    
}

/** 订单列表 */
+ (void)orderList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGOrder class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/order/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 订单详情 */
+ (void)orderView:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGOrderItem class]
                     };
        }];
        NTGOrderContent *orderContent = [NTGOrderContent objectWithKeyValues:responseObject];
        sb.onSuccess(orderContent);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/order/view.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 取消订单 */
+ (void)orderCancel:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/order/cancel.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 删除订单 */
+ (void)orderDelete:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/order/delete.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 收货地址列表 */
+ (void)getReceiverList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGReceiverContent class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/receiver/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 获取城市列表 */
+ (void)getAreaList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray *areas = [NTGArea objectArrayWithKeyValuesArray:responseObject];
        [NTGDetection alertProcessViewWithStatus:[NTGDetection netStatus] detectionString:[NTGDetection stringFromStatus:[NTGDetection netStatus]] mode:MBProgressHUDModeIndeterminate];
            [NTGMBProgressHUD alertView:@"网络正在加载！" view:[UIApplication sharedApplication].keyWindow];
        sb.onSuccess(areas);
        
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/common/area/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 保存收货地址 */
+ (void)saveReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/receiver/save.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 编辑收货地址*/
+ (void)editReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/receiver/update.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 删除收货地址*/
+ (void)deleteReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/receiver/delete.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 根据接收者ID查询地址 */
+ (void)getReceiver:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGReceiverContent *receiver = [NTGReceiverContent objectWithKeyValues:responseObject];
        sb.onSuccess(receiver);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/receiver/edit.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 用户头像 */
+ (void)getUpdateMemberHead:(NSDictionary *)params multipartFormData:(NSDictionary *)multipartFormData success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/profile/updateMemberHead.jhtml" params:params multipartFormData:multipartFormData innerSuccessWrapper:s result:sb];
}

/** 更新用户资料 */
+ (void)getUpdateMember:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/profile/updateMember.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 发送短信验证码 */
+ (void)getSMSValidCode:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/common/get_SMSValidCode.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 修改验证手机 */
+ (void)getUpdateMobile:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberSafety/updateMobile.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 修改密码 */
+ (void)getUpdatePassword:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/memberSafety/updatePassword.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 注册 */
+ (void)registerSubmit:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/register/submit4Ios.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 校验用户是否已存在 */
+ (void)registerCheck_mobile:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/register/check_mobile.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 找回密码 */
+ (void)findPassword:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/password/findPassword.jhtml" params:params innerSuccessWrapper:s result:sb];
}


/** 获取版本信息 */
+ (void)getVersion:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGAppVersion *appVersion = [NTGAppVersion objectWithKeyValues:responseObject];
        sb.onSuccess(appVersion);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/about/version.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 用户注销 */
+ (void)loginOut:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/logout.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 分销商列表 */
+ (void)supplierList:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSArray *suppliers = [NTGSupplier objectArrayWithKeyValuesArray:responseObject];
        sb.onSuccess(suppliers);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/supplier/list.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 分销商详情 */
+ (void)supplierContent:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGSupplier *supplier = [NTGSupplier objectWithKeyValues:responseObject];
        sb.onSuccess(supplier);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/member/supplier/content.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 生成组合收款单 */
+ (void) getPaymentGroup:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        sb.onSuccess(responseObject);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/payment/nSubmit.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 微信支付 */
+ (void) wechatPay:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGWechatAppBean *weixinAppBean = [NTGWechatAppBean objectWithKeyValues:responseObject];
        sb.onSuccess(weixinAppBean);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"app/payment/paymentPlugin/wechatPayApp/wechatproxy.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 支付宝支付 */
+ (void) aliPay:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
        NTGAlipayAppBean *alipayAppBean = [NTGAlipayAppBean objectWithKeyValues:responseObject];
        
        sb.onSuccess(alipayAppBean);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/payment/paymentPlugin/aliPayApp/aliPayproxy.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 综合分类搜索 */
+ (void)integrationSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
//        [NTGPage setupObjectClassInArray : ^NSDictionary *{
//            return @{
//                     @"content" : [NTGSeller class]
//                     };
//        }];
        NSArray *integrations = [NTGIntegration objectArrayWithKeyValuesArray:responseObject];
        sb.onSuccess(integrations);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/integration/search.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 首页机构搜索 */
+ (void)institutionSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGSeller class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/institution/search.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 首页跟团游搜索 */
+ (void)tripSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGTripContent class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/trip/search.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 首页保健用品搜索 */
+ (void)productSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        [NTGPage setupObjectClassInArray : ^NSDictionary *{
            return @{
                     @"content" : [NTGProductContent class]
                     };
        }];
        NTGPage *page = [NTGPage objectWithKeyValues:responseObject];
        sb.onSuccess(page);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/product/search.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 计算客房订单 */
+ (void)roomOrderCalculate:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSNumber *amount = responseObject;
        sb.onSuccess(amount);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/roomOrder/calculate.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 提交客房订单 */
+ (void)createRoomOrder:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSNumber *orderSn = responseObject;
        sb.onSuccess(orderSn);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/roomOrder/createRoomOrder.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 提交旅游订单 */
+ (void)createTripOrder:(NSDictionary *)params success:(NTGBusinessResult *)sb {
    void(^s)(id responseObject) = ^(id responseObject) {
        NSNumber *orderSn = responseObject;
        sb.onSuccess(orderSn);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodPOST urlString:@"/app/member/tripOrder/createTripOrder.jhtml" params:params innerSuccessWrapper:s result:sb];
}

/** 网路请求 */
+ (void)sendHttpRequest:(YGNetworkMethod)method urlString:(NSString *)UrlString params:(NSDictionary *)dict result:(ResultBlock)resultblock error:(ErrorBlock)errorblock {
    NTGBusinessResult* result = [[NTGBusinessResult alloc] initWithNavController:nil];
    [NTGSendRequest  sendHttpRequest:method urlString:UrlString params:dict innerSuccessWrapper:resultblock result:result];
}

/** 不需要传递二进制数据(文件)，调用此接口 */
+ (void)sendHttpRequest:(YGNetworkMethod)method urlString:(NSString *)UrlString params:(NSDictionary *)dict innerSuccessWrapper:(BusinessResultBlock)innerSuccessWrapper result:(NTGBusinessResult *)resultblock {
    resultblock.onInnerSuccessWrapper = innerSuccessWrapper;
    [NTGSendRequest sendHttpRequest:method urlString:UrlString params:dict multipartFormData:nil innerSuccessWrapper:innerSuccessWrapper result:resultblock];
}

/** 传递各种类型的数据，包含文件  */
+ (void)sendHttpRequest:(YGNetworkMethod)method urlString:(NSString *)UrlString params:(NSDictionary *)dict multipartFormData:(NSDictionary *)multipartFormData innerSuccessWrapper:(BusinessResultBlock)innerSuccessWrapper result:(NTGBusinessResult *)resultblock {
    resultblock.onInnerSuccessWrapper = innerSuccessWrapper;
    [[NTGNetworkTool sharedNetworkTool]requestMethod:method urlString:UrlString params:dict  multipartFormData:multipartFormData result:resultblock];
}

/** 新版综合分类搜索 */
+ (void)newIntegrationSearch:(NSDictionary *)params success:(NTGBusinessResult *)sb{
    void(^s)(id responseObject) = ^(id responseObject) {
//        NTGInstitutionPage *inst = [NTGInstitutionPage objectWithKeyValues:[responseObject objectForKey:@"institutionPage"]];
//        NTGProductResult *pro = [NTGProductResult objectWithKeyValues:[responseObject objectForKey:@"productPage"]];
        //        NTGIntegrationSearch *result = [[NTGIntegrationSearch alloc] init];
        //        result.institutionPage = inst;
        //        result.productPage = pro;
        
        NTGIntegrationSearch *result = [NTGIntegrationSearch objectWithKeyValues:responseObject];

        sb.onSuccess(result);
    };
    [NTGSendRequest sendHttpRequest:YGNetworkMethodGET urlString:@"/app/integration/searchEx.jhtml" params:params innerSuccessWrapper:s result:sb];}

@end
