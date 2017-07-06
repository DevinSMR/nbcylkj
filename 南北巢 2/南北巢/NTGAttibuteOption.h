/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:24:31 <br/>
 *
 */
@interface NTGAttibuteOption : NSObject

/** 属性名 */
@property(nonatomic,copy) NSString *name;

/** 属性值 */
@property(nonatomic,copy) NSString *value;

/** 选中状态控制 : 客户端控制 */
@property(nonatomic,assign) BOOL tag;

@end
