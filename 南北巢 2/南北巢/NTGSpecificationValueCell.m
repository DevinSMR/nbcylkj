/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSpecificationValueCell.h"

/**
 * view - 规格尺寸单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGSpecificationValueCell

- (void)setSpecificationBean:(NTGSpecificationBean *)specificationBean {
    _specificationBean = specificationBean;
    self.lblNmae.text = specificationBean.name;
    NSArray *specificationValues = specificationBean.specificationValues;
    int co = (int)specificationValues.count;
    CGFloat margin = 10;
    CGFloat w = 50;
    CGFloat h = 33;
    CGFloat y = 30;
    for (int i=0; i<co; i++) {
        self.colorBtn = [[UIButton alloc]init];
        self.colorBtn.layer.borderWidth = 1;
        self.colorBtn.layer.cornerRadius = 5;
        self.colorBtn.titleLabel.lineBreakMode = 0;
        self.colorBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 1 });
        [self.colorBtn.layer setBorderColor:colorref];//边框颜色
        if (i<=4) {
            self.colorBtn.frame = CGRectMake(i*(w+margin), y, w, h);
        }
        if (i>4) {
//            h = 65;
            y = h + 34;
            self.colorBtn.frame = CGRectMake((i-5)*(w+margin), y, w, h);
        }
        NTGSpecificationValueBean *specificationValue = specificationValues[i];
        [self.colorBtn setTitle:specificationValue.name forState:UIControlStateNormal];
        self.colorBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        if (specificationValue.isSelected) {
            self.colorBtn.selected = specificationValue.isSelected;
            self.colorBtn.backgroundColor = [UIColor orangeColor];
//            [self.colorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else {
            self.colorBtn.backgroundColor = [UIColor whiteColor];
            [self.colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (specificationValue.isEnabled) {
            self.colorBtn.enabled = YES;
            [self.colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else {
            self.colorBtn.enabled = NO;
            [self.colorBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        self.colorBtn.tag = specificationValue.id;
//        self.colorBtn.selected = specificationValue.isSelected;
        [self.colorBtn addTarget:self action:@selector(chooseSizeAndColor:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.colorBtn];
    }
    

    
}


/** 选中按钮 */
- (void)chooseSizeAndColor:(UIButton *)btn {
    
    btn.selected= !btn.selected;
    NTGSpecificationValueCell *cell = (NTGSpecificationValueCell *)btn.superview;
    if (![btn isEqual:self.colorBtn]) {
        self.colorBtn.selected = NO;
    }
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"tongzhi" object:nil userInfo:@{@"1":btn,@"2":cell}];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];

}

/** 移除通知 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
\

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/** 加载cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NTGSpecificationValueCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGSpecificationValueCell" owner:nil options:nil] firstObject];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

+ (instancetype)countCellWithTableView:(UITableView *)tableView{

    NTGSpecificationValueCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"NTGSpecificationValueCell" owner:nil options:nil] lastObject];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;


}

@end
