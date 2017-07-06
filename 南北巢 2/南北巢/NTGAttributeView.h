/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGAttibuteOption.h"

/**
 * view - 筛选分类列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol AttributeViewDelegate <NSObject>

/** 请求代理方 */
-(void)clickAttributeViewIndexPathRow:(NTGAttibuteOption *)attibuteOption index:(NSIndexPath *)index;

@end

//typedef void (^ReturnAttributeBlock)(NSString *option);


@interface NTGAttributeView : UIView

/** 加载视图 */
+ (instancetype)viewWithView;

/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

/** 筛选条件 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

/** 确认按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

/** 筛选条件列表 */
@property (weak, nonatomic) IBOutlet UITableView *attributeTable;

@property (nonatomic,strong) NSArray *attibuteOptions;

//@property (nonatomic, copy) ReturnAttributeBlock returnAttributeBlock;
/** 代理 */
@property (nonatomic ,weak) id<AttributeViewDelegate>delegateAttribute;
@end
