//
//  select_M.h
//  liwushuo
//
//  Created by BO on 17/4/6.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface select_M : NSObject


@property (strong,nonatomic)NSDictionary * author;
@property (strong,nonatomic)NSDictionary * column;
@property (copy,nonatomic)NSString * approved_at;
@property (copy,nonatomic)NSString * content_type;
@property (copy,nonatomic)NSString * content_url;
@property (copy,nonatomic)NSString * cover_animated_webp_url;
@property (copy,nonatomic)NSString * cover_image_url;
@property (copy,nonatomic)NSString * cover_webp_url;
@property (copy,nonatomic)NSString * editor_id;
@property (copy,nonatomic)NSString * hidden_cover_image;
@property (copy,nonatomic)NSString * ID;
@property (copy,nonatomic)NSString * introduction;
@property (copy,nonatomic)NSString * liked;
@property (copy,nonatomic)NSString * likes_count;
@property (copy,nonatomic)NSString * media_type;
@property (copy,nonatomic)NSString * published_at;
@property (copy,nonatomic)NSString * share_msg;
@property (copy,nonatomic)NSString * short_title;
@property (copy,nonatomic)NSString * status;
@property (copy,nonatomic)NSString * title;
/** 详情页 */
@property (copy,nonatomic)NSString *  url;


@end


