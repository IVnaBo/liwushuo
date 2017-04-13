//
//  giftVCollectionCell.m
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "giftVCollectionCell.h"

@implementation giftVCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.giftimgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width , self.height)];
//        self.giftimgV.contentMode = UIViewContentModeScaleAspectFit;
//        NSLog(@"%.2f",self.width);
        [self.contentView addSubview:self.giftimgV];
        
    }
    return self;
}
-(void)setModel:(gift_M *)model
{
    _model = model;
    if (model.image_url) {
        NSURL * url = [NSURL URLWithString:model.image_url];
        [self.giftimgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"socute"]];
    }

    self.target_url = model.target_url;
}
@end
