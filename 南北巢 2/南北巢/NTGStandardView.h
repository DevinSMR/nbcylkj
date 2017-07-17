//
//  NTGStandardView.h
//  南北巢
//
//  Created by nbc on 17/7/13.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTGAttribute.h"
/**
 * view - 属性筛选视图
 *
 * @author nbcyl Team
 * @version 1.0
 */
@interface NTGStandardView : UIView
@property (weak, nonatomic) IBOutlet UIButton *chooseAreaBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *standardView;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic,strong) NSArray *attributes;
/** 加载视图 */
+ (instancetype)viewWithView;

@end
