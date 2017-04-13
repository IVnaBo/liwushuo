//
//  Hot_model.m
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "Hot_model.h"

@implementation Hot_model
-(instancetype)initwithDic:(NSDictionary *)dic
{
    self.image_urls = dic[@"image_urls"];
    self.cover_image_url = dic[@"cover_image_url"];
    self.desc = dic[@"description"];
    self.editor_id = dic[@"editor_id"];
    self.favorites_count = dic[@"favorites_count"];
    self.is_favorite = dic[@"is_favorite"];
    self.keywords = dic[@"keywords"];
    self.name = dic [@"name"];
    self.price = dic[@"price"];
    self.purchase_id = dic[@"purchase_id"];
    self.purchase_status = dic[@"purchase_status"];
    self.purchase_shop_id = dic[@"purchase_shop_id"];
    self.purchase_url = dic[@"purchase_url"];
    self.short_description = dic[@"short_description"];
    self.subcategory_id = dic[@"subcategory_id"];
    self.url = dic[@"url"];
    
    return self;
}


@end
