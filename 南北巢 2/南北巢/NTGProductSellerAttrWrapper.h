/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>
#import "NTGPage.h"


/**
 *  Entity - 所有类别商品、机构的分页及属性容器bean
 *
 * @author dawei
 *
 * @version 2015-3-26 下午4:21:55 <br/>
 *
 */
@interface NTGProductSellerAttrWrapper : NSObject
/** 商品分页数据  */
@property(nonatomic,strong) NTGPage *page;

/** 商品的筛选属性 */
@property(nonatomic,strong) NSArray *attribute;
@end
