//
//  sortCollectionViewCell.m
//  liwushuo
//
//  Created by BO on 17/4/11.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "sortCollectionViewCell.h"

@implementation sortCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        150/ 73.5
        [self setupUI];
    }
    return self;
}
-(void)setModel:(SortModel *)model
{
    _model = model;
    [self.imgv sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"宝贝默认图"]];
//    self.sortlab.text = model.category;
    self.author.text = model.author;
    self.sortlab.text = model.title;
    self.categorylab.text = model.category;
    
}
-(void)setupUI
{
    //(iPhone_W/2 - 15 , 160);
//    self.backgroundColor = [UIColor whiteColor];
    self.imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 73.5)];
    self.imgv.image = [UIImage imageNamed:@"宝贝默认图"];
    self.sortlab = [[UILabel alloc]initWithFrame:CGRectMake(10 , self.imgv.y + self.imgv.height, 100, 25)];
    self.sortlab.font = [UIFont boldSystemFontOfSize:15.0];
    self.sortlab.text = @"因礼不同";
    
    self.categorylab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.sortlab.y+self.sortlab.height + 5, 100, 25)];
    self.categorylab.font = [UIFont systemFontOfSize:13.0];
    self.categorylab.text = @"礼物";
    self.author = [[UILabel alloc]initWithFrame:CGRectMake(10, self.categorylab.y + self.categorylab.height + 5, 100, 20)];
    self.author.font = [UIFont systemFontOfSize:13.0];
    self.author.text = @"小礼君";
    [self addSubview:self.imgv];
    [self addSubview:self.sortlab];
    [self addSubview:self.categorylab];
    [self addSubview:self.author];
}
@end
