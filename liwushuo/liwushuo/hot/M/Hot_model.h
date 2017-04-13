//
//  Hot_model.h
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hot_model : NSObject
@property (strong,nonatomic)NSArray * image_urls;
@property (copy,nonatomic)NSString * cover_image_url;
@property (copy,nonatomic)NSString * desc;
@property (copy,nonatomic)NSString * editor_id;
@property (copy,nonatomic)NSString * favorites_count;
@property (copy,nonatomic)NSString * is_favorite;
@property (copy,nonatomic)NSString * keywords;
@property (copy,nonatomic)NSString * name;
@property (copy,nonatomic)NSString * price;
@property (copy,nonatomic)NSString * purchase_id;
@property (copy,nonatomic)NSString * purchase_shop_id;
@property (copy,nonatomic)NSString * purchase_status;
@property (copy,nonatomic)NSString * purchase_type;
@property (copy,nonatomic)NSString * purchase_url;
@property (copy,nonatomic)NSString * short_description;
@property (copy,nonatomic)NSString * subcategory_id;
@property (copy,nonatomic)NSString * url;

/**
 init
 @param dic dic
 @return __
 */
-(instancetype)initwithDic:(NSDictionary *)dic;
@end
