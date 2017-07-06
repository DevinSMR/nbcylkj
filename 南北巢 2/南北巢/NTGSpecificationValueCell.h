/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>
#import "NTGSpecificationBean.h"

/**
 * view - 规格尺寸单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@protocol changeProductCountDelegate <NSObject>

-(void)reduceCount:(NSString *)count;
-(void)addCount:(NSString *)count;

@end
@interface NTGSpecificationValueCell : UITableViewCell

/** 加载单元格类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

//加载购买数量单元格

@property (nonatomic,strong) NTGSpecificationBean *specificationBean;
+ (instancetype)countCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *lblNmae;

@property (nonatomic,strong) UIButton *colorBtn;

//购买数量
@property (weak, nonatomic) IBOutlet UILabel *countLb;

//增加
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
//减少
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;

@property (nonatomic,weak) id<changeProductCountDelegate>countDelegate;
@end
