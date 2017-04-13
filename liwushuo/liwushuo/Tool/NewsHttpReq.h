//
//  NewsHttpReq.h
//  News
//
//  Created by BOBO on 16/11/18.
//  Copyright © 2016年 BOBO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone,  // 没有网络
    NetworkStates2G,    // 2G
    NetworkStates3G,    // 3G
    NetworkStates4G,    // 4G
    NetworkStatesWIFI   // WIFI
};

@interface NewsHttpReq : NSObject

/**
 get方式天气网络请求

 @param URLstr  请求路径
 @param parmmer 请求参数
 @param sucess  成功返回
 @param failure 失败返回
 */
+ (void)get:(NSString *)URLstr parm:(id)parmmer sucess:(void (^)(id responseObject))sucess failure:(void (^)(NSError *error))failure;

/**
 post方式新闻数据请求

 @param URLstr  url
 @param parmmer 参数
 @param sucess  成功返回
 @param failure 失败返回
 */
+ (void)Post:(NSString *)URLstr parm:(id)parmmer sucess:(void (^)(id responseObject))sucess failure:(void (^)(NSError *error))failure;

/**
 控制器消失的时候 请求失效
 */
+ (void)invalidateSessionCancelingTasks;
/**
 取消所有的网络请求. 
 */
+ (void)newsHttpCancelAllRequest;

/** 判断网络类型 */
+ (NetworkStates)getNetworkStates;
@end
