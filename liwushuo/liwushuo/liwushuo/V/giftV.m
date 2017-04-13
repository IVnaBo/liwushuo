//
//  giftV.m
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "giftV.h"
#import "giftVCollectionCell.h"
#import "gift_M.h"
static NSString * giftCollectID = @"giftCollectionV";
@implementation giftV

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        
//        layout.itemSize = CGSizeMake(100, frame.size.height/2.0);
//        //UIEdgeInsetsMake(10, 10, 10, 10);
//        layout.sectionInset
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        self.giftCollectionV = [[UICollectionView alloc]initWithFrame
                                :CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout
                                :layout];
        
        [self.giftCollectionV registerClass:
         [giftVCollectionCell class] forCellWithReuseIdentifier:giftCollectID];
        
        self.giftCollectionV.backgroundColor = [UIColor clearColor];
        
        self.giftCollectionV.delegate   = self;
        
        self.giftCollectionV.dataSource = self;
        
//        self.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        
        [self addSubview:self.giftCollectionV];
    }
    return self;
}
-(void)setInfoArr:(NSArray *)infoArr
{
    _infoArr = infoArr;
    [self.giftCollectionV reloadData];
}

#pragma mark - dat - 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infoArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    giftVCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:giftCollectID forIndexPath:indexPath];
    gift_M * model = self.infoArr[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((iPhone_W - 30 )/3.0  , ((iPhone_W - 30) / 3.0) * 0.664);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    /** 上左下右 */
    return UIEdgeInsetsMake(5, 10, 5, 5);
}

@end
