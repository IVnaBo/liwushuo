//
//  gift_M.m
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "gift_M.h"

@implementation gift_M

-(instancetype)initwithDic:(NSDictionary *)dic
{
    if (self) {
        self.target_url = [NSString stringWithFormat:@"%@",dic[@"target_url"]];
        self.image_url  = [NSString stringWithFormat:@"%@",dic[@"image_url"]];
        self.webp_url   = [NSString stringWithFormat:@"%@",dic[@"webp_url"]];
    }
    return  self;
}

@end
