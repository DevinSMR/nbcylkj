/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGGuideViewController.h"
#import "UIView+HMExt.h"
#import "NTGGuideViewCell.h"

/**
 * control - 新特性控制器
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *imgViewGuide;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation NTGGuideViewController

static NSString * const reuseIdentifier = @"guide_cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个cell的大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置行间距为0
    flowLayout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:flowLayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[NTGGuideViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 取消滚动的时候的弹簧效果
    self.collectionView.bounces = NO;
    
    // 取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置UIScrollView可以自动分页
    self.collectionView.pagingEnabled = YES;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake( 100, height - 77, width - 200, 40)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:248/255.0 green:111/255.0 blue:77/255.0 alpha:1];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.userInteractionEnabled = NO;
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];
    self.collectionView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NTGGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *strName = [NSString stringWithFormat:@"guide%@", @(indexPath.row + 1)];
    
    [cell setPage:(int)indexPath.row total:4];
    
    // 设置图片内容
    cell.imgName = strName;
    
    return cell;
}




-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.pageControl.currentPage = scrollView.contentOffset.x /[UIScreen mainScreen].bounds.size.width;
    NSLog(@"这个方法走了");
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
