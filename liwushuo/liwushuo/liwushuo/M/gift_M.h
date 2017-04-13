//
//  gift_M.h
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gift_M : NSObject

@property (copy,nonatomic)NSString * image_url;
@property (copy,nonatomic)NSString * target_url;
@property (copy,nonatomic)NSString * webp_url;
-(instancetype)initwithDic:(NSDictionary *)dic;
@end
