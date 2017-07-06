/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGOrderType.h"
#import "NTGAttribute.h"

/**
 * view - 排序
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGOrderType

/** 加载Xib */
- (UIView *)viewWithRect:(CGRect)rect attrs:(NSMutableArray *) attrs{
//    NTGOrderType *orderType = [[[NSBundle mainBundle]loadNibNamed:@"NTGOrderType" owner:nil options:nil] lastObject];
    //self.attrs = [NSMutableArray array];
    self.attrsDict = [NSMutableDictionary dictionary];
    NTGOrderType *orderTypeView = [[NTGOrderType alloc]initWithFrame:rect];
    for (int i = 0; i<attrs.count; i++) {
        NTGAttribute *attr = attrs[i];
        NSArray *options = attr.option;
        for (int j =0; j<options.count; j++) {
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 5+40*j, rect.size.width-20, 30)];
            lbl.font = [UIFont systemFontOfSize:14];
            NTGAttibuteOption *aOption = (NTGAttibuteOption *)options[j];
            if (aOption.tag) {
                lbl.textColor = [UIColor orangeColor];
            }else {
                lbl.textColor = [UIColor blackColor];
            }
            lbl.text = ((NTGAttibuteOption *)options[j]).name;
            [orderTypeView addSubview:lbl];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 40*j, rect.size.width, 40)];
            btn.tag = 1000000*i + j;
            [btn addTarget:self action:@selector(sortBtn:) forControlEvents:UIControlEventTouchUpInside];
            [orderTypeView addSubview:btn];
            NTGAttribute *attr = attrs[i];
            NTGAttribute *cloneAttr = [attr cloneObject];
            cloneAttr.option = [NSMutableArray arrayWithObject:options[j]];
            [self.attrsDict setObject:cloneAttr forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        }
    }
    orderTypeView.backgroundColor = [UIColor whiteColor];
    return orderTypeView;
}


- (void)sortBtn:(UIButton *)btn {//attr:(NTGAttribute *)attr {
    NSString *keys = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    NTGAttribute *attr = [self.attrsDict valueForKey:keys];
    //修改选中状态
    if ([_orderTypeDelegate respondsToSelector:@selector(dataFilter:)]) {
      [_orderTypeDelegate dataFilter:attr];
    }
}

//+ (UIView *)
@end
