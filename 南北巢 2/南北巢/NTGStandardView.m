//
//  NTGStandardView.m
//  南北巢
//
//  Created by nbc on 17/7/13.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGStandardView.h"
#import "NTGStandardReusableView.h"
#import "NTGStandardCell.h"
#import "NTGCustomLayout.h"
@interface NTGStandardView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation NTGStandardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setAttributes:(NSArray *)attributes{
    if (attributes != nil) {
        _attributes = attributes;
        [self.standardView reloadData];
    }


}

/** 加载Xib */
-(void)awakeFromNib{
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 2;

    flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
    
    self.standardView.collectionViewLayout = flowLayout;
    self.standardView.delegate = self;
    self.standardView.dataSource = self;
//    self.standardView.collectionViewLayout = [[NTGCustomLayout alloc] init];
    [self.standardView registerNib:[UINib nibWithNibName:@"NTGStandardCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.standardView registerNib:[UINib nibWithNibName:@"NTGStandardReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];


}
+ (instancetype)viewWithView {
    NTGStandardView *standardView = [[[NSBundle mainBundle]loadNibNamed:@"NTGStandardView" owner:nil options:nil] lastObject];
    
    return standardView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.attributes.count - 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NTGAttribute *attribute = self.attributes[section + 1];
    return attribute.option.count;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    NTGAttribute *attribute = self.attributes[indexPath.section + 1];
        if (kind == UICollectionElementKindSectionHeader){
            NTGStandardReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
            headerView.headerLabel.text = attribute.name;
            NSLog(@"%@",headerView.headerLabel.text);

            reusableview = headerView;
        }
        
     return reusableview;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NTGStandardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NTGAttribute *attribute = self.attributes[indexPath.section + 1];
    NTGAttibuteOption *option = attribute.option[indexPath.row];
    cell.contentLb.text = option.name;
    NSLog(@"%@",cell.contentLb.text);
    return cell;



}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 45);
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NTGAttribute *attribute = self.attributes[indexPath.section + 1];
//    NTGAttibuteOption *option = attribute.option[indexPath.row];
//
//    NSString *str =  option.name;
//    if (str.length > 0) {
//        return [NTGStandardCell getSizeWithText:str];
//    }
    if (indexPath.section == 2) {
        return CGSizeMake(96, 34);
    }
    return CGSizeMake(69, 34);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NTGStandardCell *cell = (NTGStandardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentLb.backgroundColor = [UIColor redColor];



}


@end
