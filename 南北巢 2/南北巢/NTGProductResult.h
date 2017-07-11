//
//  NTGProductResult.h
//  南北巢
//
//  Created by nbc on 17/7/7.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * Entity -综合分类搜索养老产品结果
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGProductResult : NSObject
@property (nonatomic,strong) NSArray *content;
@property (nonatomic,strong) NSString *total;
@end
