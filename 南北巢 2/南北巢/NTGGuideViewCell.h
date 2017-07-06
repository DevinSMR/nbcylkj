/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 新特性单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgName;

- (void)setPage:(int)page total:(int)total;
@end
