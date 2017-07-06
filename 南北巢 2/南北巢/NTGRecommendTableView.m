/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGRecommendTableView.h"
#import "NTGRecommend.h"

/**
 * view - 商品推荐列表
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGRecommendTableView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation NTGRecommendTableView

- (void)setProducts:(NSArray *)products {
    _products = products;
    [self reloadData];
}

/** 数据源、代理 */
-(void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource=self;
    self.delegate=self;
    [self registerClass:[NTGRecommend class] forCellWithReuseIdentifier:@"recommendProduct"];
    self.scrollEnabled = NO;
}

#pragma 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (NTGRecommend *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NTGRecommend *cell  = (NTGRecommend *)[collectionView dequeueReusableCellWithReuseIdentifier:@"recommendProduct" forIndexPath:indexPath];

    cell.product = self.products[indexPath.item];
    return cell; 
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_delegateRec respondsToSelector:@selector(clickindexPathRow:index:)]) {
        [_delegateRec clickindexPathRow:_products[indexPath.item] index:(int)indexPath.item];
    }
    self.index=indexPath;
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
