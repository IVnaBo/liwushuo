//
//  sortCollectionViewCell.h
//  liwushuo
//
//  Created by BO on 17/4/11.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortModel.h"
@interface sortCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView * imgv;
@property (nonatomic,strong)UILabel * sortlab;
@property (nonatomic,strong)UILabel * categorylab;//礼物
@property (nonatomic,strong)UILabel * author;//小礼君...
@property (nonatomic,strong)SortModel * model;
@end
