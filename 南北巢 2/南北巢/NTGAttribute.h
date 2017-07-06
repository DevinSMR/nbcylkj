/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGAttibuteOption.h"
/**
 * Entity - 筛选参数
 * @author 谷强
 * @vertion 2015 Apr 16, 2015 4:59:01 PM
 */
@interface NTGAttribute : NSObject

/** 属性名称 */
@property(nonatomic,copy) NSString *name;

/** 属性值 */
@property(nonatomic,copy) NSString *value;

/** 属性选项 */
@property(nonatomic,strong) NSArray *option;

- (NTGAttribute *)cloneObject;

- (void)changeAllOptionsTag:(BOOL)tag;

@end
