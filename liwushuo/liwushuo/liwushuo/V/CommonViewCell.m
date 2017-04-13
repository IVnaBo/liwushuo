//
//  CommonViewCell.m
//  liwushuo
//
//  Created by BO on 17/4/5.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "CommonViewCell.h"

@implementation CommonViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSelect_model:(select_M *)select_model
{
    _select_model = select_model;
    NSDictionary * author = select_model.author;
    NSString * aver_url = author[@"avatar_url"];
    [self.iconImgv sd_setImageWithURL:[NSURL URLWithString:aver_url] placeholderImage:[UIImage imageNamed:@"socute"]];
    self.iconNlab.text = author[@"nickname"];
    self.iconPislab.text = author [@"introduction"];
    
    NSString * goods = select_model.cover_image_url;
    
    [self.goodsImgv sd_setImageWithURL:[NSURL URLWithString:goods] placeholderImage:[UIImage imageNamed:@"socute"]];
    self.deslab.text = select_model.introduction;
    self.sloganlab.text = select_model.title;
    self.feednumlab.text = select_model.likes_count;
    // url 跳转到详情页的URL
}
-(void)setAuthor_model:(author *)author_model
{
    _author_model = author_model;
//    [self.iconImgv sd_setImageWithURL:[NSURL URLWithString:author_model.avatar_url] placeholderImage:[UIImage imageNamed:@"socute"]];
    
}
-(void)setColumn_model:(column *)column_model
{
    _column_model = column_model;

  
    
}
@end
