//
//  MjConfig.m
//  liwushuo
//
//  Created by BO on 17/3/30.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "MjConfig.h"
#import <MJExtension/MJExtension.h>
@implementation MjConfig
// 加载到内存的时候会自动调用,不用我们去调用它
+ (void)load
{
    // 遇到模型中带有id,全部写成ID,自动替换这个属性名
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id",
                 @"desc" : @"description",
                 @"def" : @"default"
                 };
    }];
}
@end
