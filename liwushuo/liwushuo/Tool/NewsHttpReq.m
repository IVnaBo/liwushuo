//
//  NewsHttpReq.m
//  News
//
//  Created by BOBO on 16/11/18.
//  Copyright © 2016年 BOBO. All rights reserved.
//

#import "NewsHttpReq.h"


/**
 AFHTTPSessionManager Category
 */
@interface AFHTTPSessionManager (newsNetShare)

/**
 构建单例方法 （天气请求）

 @return AFHTTPSessionManager
 */
+(instancetype)WeatherShareInstance;

@end
@implementation AFHTTPSessionManager (newsNetShare)

+(instancetype)WeatherShareInstance
{
    static AFHTTPSessionManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
        
        _instance.requestSerializer=[AFHTTPRequestSerializer serializer];
        _instance.responseSerializer=[AFHTTPResponseSerializer serializer];
        [_instance.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _instance.requestSerializer.timeoutInterval = 10.f;
        [_instance.requestSerializer didChangeValueForKey:@"timeoutInterval"];
         static NSString * netValue = @"hahaha";
         [_instance.requestSerializer setValue:netValue forHTTPHeaderField:@"authCode"];
        
    });
    return _instance;
    

}

@end
@implementation NewsHttpReq
+(void)get:(NSString *)URLstr parm:(id)parmmer sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    
    NetworkStates states = [self getNetworkStates];
    if (states != NetworkStatesNone) {  // 有网
    
        AFHTTPSessionManager *Manager=[AFHTTPSessionManager WeatherShareInstance];
        [Manager GET:URLstr parameters:parmmer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            if (sucess) {
                sucess(obj);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {    // 无网
//        [XSQProgressHUD dismiss];
        NSLog(@"显示网络图片");
    }
}

/**
 post方式新闻数据请求
 
 @param URLstr  url
 @param parmmer 参数
 @param sucess  成功返回
 @param failure 失败返回
 */
+(void)Post:(NSString *)URLstr parm:(id)parmmer sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    NetworkStates states = [self getNetworkStates];
    
    if (states != NetworkStatesNone) {  // 有网
        AFHTTPSessionManager *Manager=[AFHTTPSessionManager WeatherShareInstance];
        [Manager POST:URLstr parameters:parmmer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            if (sucess) {
                sucess(obj);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {    // 无网
//        [XSQProgressHUD dismiss];
        NSLog(@"显示网络图片");
    }
}

/**
 取消所有网络请求.
 */
+(void)newsHttpCancelAllRequest
{
    AFHTTPSessionManager *Manager=[AFHTTPSessionManager WeatherShareInstance];
    [Manager.operationQueue cancelAllOperations];
}

// 判断网络类型
+ (NetworkStates)getNetworkStates
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    //无网模式
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                    states = NetworkStatesWIFI;
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}


#pragma mark - 控制器死的时候让请求失效
+ (void)invalidateSessionCancelingTasks
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager WeatherShareInstance];
    
    [manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - 取消任务
+ (void)cancel
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager WeatherShareInstance];
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
