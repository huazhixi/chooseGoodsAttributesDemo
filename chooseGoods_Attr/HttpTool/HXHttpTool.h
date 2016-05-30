//
//  LXHttpTool.h
//  Drinker
//
//  Created by LingXiu on 15/8/24.
//  Copyright (c) 2015年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HXHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  只有参数
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  POST带图片
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))constructingBodyWithBlock success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
