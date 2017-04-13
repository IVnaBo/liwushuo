//
//  HotCollectionViewCell.h
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hot_model.h"
@interface HotCollectionViewCell : UICollectionViewCell
/** 商品名字 */
@property (strong,nonatomic)UIImageView * goodsImgv;
/** 小标题 */
@property (strong,nonatomic)UILabel * shortTlab;
/** 描述 */
@property (strong,nonatomic)UILabel * deslab;
/** 价格 */
@property (strong,nonatomic)UILabel * pricelab;


@property (nonatomic,strong)Hot_model * model;
@end
