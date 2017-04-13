//
//  ShareInstance.m
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "ShareInstance.h"


static ShareInstance * instance;
@implementation ShareInstance

+(instancetype)shareSingleton{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[ShareInstance alloc]init];
        }
    }
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (instance == nil) {
        instance = [[super allocWithZone:zone]init];
    }
    return instance;
}
@end
