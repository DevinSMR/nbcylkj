/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGGuideTable.h"

/**
 * view - 巢友指南列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@implementation NTGGuideTable

- (void)setScenicRegions:(NSArray *)scenicRegions {
    _scenicRegions = scenicRegions;
    [self reloadData];
}


- (void)addScenicRegions:(NSArray *)scenicRegions {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_scenicRegions];
    [temp addObjectsFromArray:scenicRegions];
    _scenicRegions = temp;
    [self reloadData];
}

-(void)clearScenicRegions {
    _scenicRegions = [NSMutableArray array];
    [self reloadData];
}

@end
