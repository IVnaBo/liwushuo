//
//  categoryCollectionViewCell.m
//  liwushuo
//
//  Created by BO on 17/4/12.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "categoryCollectionViewCell.h"

@implementation categoryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //513 282
        self.goodsImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (iPhone_W - 30)/2.0,((iPhone_W - 30)/2.0)*282/513)];
        [self addSubview:self.goodsImgv];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setModel:(styleModel *)model
{
    _model = model;
    [self.goodsImgv sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"宝贝默认图"]];
}
@end
