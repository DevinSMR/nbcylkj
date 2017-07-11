//
//  NTGIntegrationSearch.h
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTGInstitutionPage.h"
#import "NTGProductResult.h"
/**
 * Entity -综合分类搜索
 *
 * @author nbcyl Team
 * @version 3.0
 */


@interface NTGIntegrationSearch : NSObject
/** 机构 */
@property(nonatomic,strong) NTGInstitutionPage *institutionPage;
/** 产品 */
@property(nonatomic,strong) NTGProductResult *productPage;
@end
