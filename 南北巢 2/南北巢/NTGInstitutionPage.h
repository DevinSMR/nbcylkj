//
//  NTGInstitutionPage.h
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * Entity -综合分类搜索养老机构结果
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGInstitutionPage : NSObject
@property (nonatomic,copy) NSArray *content;
@property (nonatomic,copy) NSString *total;
@end
