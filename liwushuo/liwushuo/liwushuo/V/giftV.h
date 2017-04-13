//
//  giftV.h
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface giftV : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)UICollectionView * giftCollectionV;
@property (strong,nonatomic)NSArray          * infoArr;
-(instancetype)initWithFrame:(CGRect)frame;
@end
