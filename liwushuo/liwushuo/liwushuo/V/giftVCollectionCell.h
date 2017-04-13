//
//  giftVCollectionCell.h
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gift_M.h"
@interface giftVCollectionCell : UICollectionViewCell

@property (strong,nonatomic)UIImageView * giftimgV;
@property (strong,nonatomic)UILabel     * giftTitlesLab;
@property (strong,nonatomic)gift_M      * model;
@property (copy , nonatomic)NSString    * target_url;
-(instancetype)initWithFrame:(CGRect)frame;
@end
