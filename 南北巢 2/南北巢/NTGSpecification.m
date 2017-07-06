/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGSpecification.h"

//#import "NTGSelectSpecificationValue.h"

/**
 * view - 规格尺寸
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGSpecification

/** 加载Xib */
+ (instancetype)viewWithView {
    NTGSpecification *specification = [[[NSBundle mainBundle]loadNibNamed:@"NTGSpecification" owner:nil options:nil] lastObject];
    return specification;
}

@end
