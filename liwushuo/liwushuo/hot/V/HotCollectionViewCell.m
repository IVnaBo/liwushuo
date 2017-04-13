//
//  HotCollectionViewCell.m
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "HotCollectionViewCell.h"

@implementation HotCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.goodsImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (iPhone_W - 40 )/2.0, (iPhone_W - 40 )/2.0)];

    [self addSubview:self.goodsImgv];
    
    self.shortTlab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.goodsImgv.height + 5, self.width - 20, 25)];
    self.shortTlab.font = [UIFont boldSystemFontOfSize:15.0];

    [self addSubview:self.shortTlab];
    
    self.deslab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.shortTlab.y + self.shortTlab.height + 5, self.width - 20, 35)];
    self.deslab.font = [UIFont systemFontOfSize:14.0];
    self.deslab.numberOfLines = 2.;

    [self addSubview:self.deslab];
    
    self.pricelab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.deslab.y + self.deslab.height + 5, 75, 25)];
    self.pricelab.textColor = [UIColor redColor];
    self.pricelab.font = [UIFont systemFontOfSize:14.0];

    [self addSubview:self.pricelab];
}

-(void)setModel:(Hot_model *)model
{
    
        _model = model;
        [self.goodsImgv sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"socute"]];
        self.shortTlab.text = model.short_description;
        self.deslab.text = model.name;
        self.pricelab.text = [NSString stringWithFormat:@"￥%@",model.price];

}

@end
