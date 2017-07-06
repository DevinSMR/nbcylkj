/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <UIKit/UIKit.h>

/**
 * view - 巢友指南列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideTable : UITableView
@property (nonatomic,strong) NSArray *scenicRegions;

- (void)addScenicRegions:(NSArray *)scenicRegions;

-(void)clearScenicRegions;
@end
