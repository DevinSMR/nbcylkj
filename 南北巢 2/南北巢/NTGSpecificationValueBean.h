//
//  NTGSpecificationValueBean.h
//  南北巢
//
//  Created by nbc on 16/5/13.
//  Copyright © 2016年 NBCYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTGSpecificationValueBean : NSObject
/** id */
//private Long id;
@property (nonatomic,assign) long id;
/** 名称 */
//private String name;
@property (nonatomic,copy) NSString *name;

/** 图片 */
//private String image;
@property (nonatomic,copy) NSString *image;

/** 是否选中 */
@property (nonatomic,assign) BOOL isSelected;

/** 是否禁用 */
//private Boolean isEnabled;
@property (nonatomic,assign) BOOL isEnabled;
@end
