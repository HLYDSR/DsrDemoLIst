//
//  SharedAction.m
//  UpdateImages
//
//  Created by DengShiru on 16/7/3.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "SharedAction.h"

@implementation SharedAction

//Post
+(void)upLoadOneImageWithUrl:(NSString *)url
               andParameters:(NSDictionary *)parameters
                    andImage:(UIImage *)image
                andImageName:(NSString *)imageName
            andInterfaceName:(NSString *)interfaceName
              withCompletion:(completion) completed{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [session POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageData) {
            [formData appendPartWithFileData:imageData name:interfaceName fileName:[NSString stringWithFormat:@"%@.jpg",imageName] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];

}

//post
+(void)postNoImageWithUrl:(NSString *)url
               parameters:(NSDictionary *)parameters
           withCompletion:(completion) completed{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    //    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
}

//上传多张图片
+(void)upLoadImagesWithUrl:(NSString *)url
             andParameters:(NSDictionary *)parameters
                imageArray:(NSArray *)imageArray
              andImageName:(NSString *)imageName
          andInterfaceName:(NSString *)interfaceName
            withCompletion:(completion) completed{
    NSDate *confromTimesp = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[confromTimesp timeIntervalSince1970]];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        for (int i=0; i<imageArray.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@[%d]",interfaceName,i] fileName:[NSString stringWithFormat:@"%@%@%d.jpg",imageName,timeSp,i] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionTask *task, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
    
}


+(void)operationAfterFailActionWithUrl:(NSString *)url
                         andPatameters:(NSDictionary *)parameters
                              andError:(NSError *)error withCompletion:(completion) completed{
    [self logUrl:url parameters:parameters];
    NSLog(@"Error: %@", error);
    completed(NO, nil);
    NSLog(@"上传 失败");
}

+(void)operationAfterSucccessActionWithOperation:(AFJSONResponseSerializer *)operation andResponseObject:(id)responseObject
                                          andUrl:(NSString *)url
                                   andParameters:(NSDictionary *)parameters
                                  withCompletion:(completion) completed{
    NSLog(@"Success: ***** %@ ***** ", operation);
    
    [self logUrl:url parameters:parameters];
    NSNumber *status = responseObject[@"status"];
    NSLog(@"status = %@", status);
    /**
     *  这里是用来判断的  当服务器上传成功之后会调用这里  规则根据相应的设置进行修改
     */
    if (![operation isEqual:@200]) {
        completed(NO, responseObject);
    } else {
        completed(YES, responseObject);
    }
}



+(void) logUrl:(NSString *)url parameters:(NSDictionary *)parameters {
    NSString *fullUrl = [NSString stringWithFormat:@"%@", url];
    int index = 0;
    for (NSString *key in parameters) {
        if (index == 0) {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"?"];
        } else {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"&"];
        }
        fullUrl = [NSString stringWithFormat:@"%@%@=%@", fullUrl, key, parameters[key]];
        index ++;
    }
    NSLog(@"*** url ***: %@", fullUrl);
}


@end
