/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
@class NTGOrder;

/**
 * view - 订单
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol NTGOrderCellDelegate <NSObject>

/** 请求代理方 */
-(void)clickBtn:(NTGOrder *)order button:(UIButton *)btn;

@end

@interface NTGOrderCell : UITableViewCell

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 查看物流 */
@property (weak, nonatomic) IBOutlet UIButton *deliveryBtn;

/** 评价订单 */
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;

/** 取消订单 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic,strong) NTGOrder *order;
@property (nonatomic,copy) NSString *orderType;

/** 代理 */
@property (nonatomic ,weak) id<NTGOrderCellDelegate>delegateOrderCell;
@end
