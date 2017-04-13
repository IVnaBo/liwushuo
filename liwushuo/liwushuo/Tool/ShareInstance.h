//
//  ShareInstance.h
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareInstance : NSObject
/** 网络状态... */
@property (copy,nonatomic)NSString * netWorkState;

+(instancetype)shareSingleton;
@end
