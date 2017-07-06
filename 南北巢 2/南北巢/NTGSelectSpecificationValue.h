//
//  NTGSelectSpecificationValue.h
//  南北巢
//
//  Created by nbc on 16/5/13.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTGProductContent.h"
#import "NTGSpecificationBean.h"

@interface NTGSelectSpecificationValue : NSObject

/** 选择规格对应的商品 */

@property (nonatomic,strong) NTGProductContent *product;

/** 规格 */
@property (nonatomic,strong) NSArray *effectiveSpecifications;

@end
