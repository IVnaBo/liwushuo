//
//  styleModel.h
//  liwushuo
//
//  Created by BO on 17/4/12.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface styleModel : NSObject

/**
 "cover_image_url": "http://img03.liwushuo.com/image/161108/a9lk7ujyu.png",
 "group_id": 5,
 "icon_url": "http://img02.liwushuo.com/image/160414/kwzqtscoa.png-pw144",
 "id": 111,
 "items_count": 1219,
 "name": "礼物",
 "order": 10,
 "status": 0,
 "url": ""
 */
@property (nonatomic,copy)NSString *cover_image_url;
@property (nonatomic,copy)NSString *group_id;
@property (nonatomic,copy)NSString *icon_url;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *items_count;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *order;
@property (nonatomic,copy)NSString *status;
@end
