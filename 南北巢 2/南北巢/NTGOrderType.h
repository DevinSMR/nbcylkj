/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGAttibuteOption.h"
@class NTGAttribute;

/**
 * view - 排序
 *
 * @author nbcyl Team
 * @version 3.0
 */
@protocol NTGOrderTypeDelegate <NSObject>

/** 请求代理方 */
-(void)dataFilter:(NTGAttribute *) attr; /*(UIButton *)btn btnTag:(int)tag */ ;
-(void)dataFilters:(NSArray *) attrs;
@end

@interface NTGOrderType : UIView

/** 加载视图 */
- (UIView *)viewWithRect:(CGRect)rect attrs:(NSMutableArray *)attrs;

//@property(nonatomic,strong) NSMutableArray *attrs;

@property(nonatomic,strong) NSMutableDictionary *attrsDict;

/** 代理 */
@property (nonatomic ,weak) id<NTGOrderTypeDelegate>orderTypeDelegate;

@end
