/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 商品图片
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGProductImage : NSObject

/** 标题 */
@property(nonatomic,copy) NSString *title;

/** 中图片 */
@property(nonatomic,copy) NSString *medium;
@end
