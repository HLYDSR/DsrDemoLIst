//
//  SharedAction.h
//  UpdateImages
//
//  Created by DengShiru on 16/7/3.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^doneWithObject)(id object);
typedef void (^completion)(BOOL completed, NSDictionary *data);

@interface SharedAction : NSObject
/**
 *  上传一张图片
 *
 *  @param url           post链接地址
 *  @param parameters    上传参数
 *  @param image         图片文件
 *  @param imageName     图片命名
 *  @param interfaceName 接受图片字段名称    ****必须与服务器接收字段相同****
 *  @param completed     回调
 */
+(void)upLoadOneImageWithUrl:(NSString *)url
               andParameters:(NSDictionary *)parameters
                    andImage:(UIImage *)image
                andImageName:(NSString *)imageName
            andInterfaceName:(NSString *)interfaceName
              withCompletion:(completion) completed;
/**
 *  扑通的post参数方法
 *
 *  @param url        post链接地址
 *  @param parameters 上传参数
 *  @param completed  回调
 */
+(void)postNoImageWithUrl:(NSString *)url
               parameters:(NSDictionary *)parameters
           withCompletion:(completion) completed;


/**
 *  上传多张图片
 *
 *  @param url           post链接地址
 *  @param parameters    上传参数
 *  @param imageArray    图片数组
 *  @param imageName     图片命名
 *  @param interfaceName 接受图片字段     ****必须与服务器接收字段相同****
 *  @param completed     回调
 */
+(void)upLoadImagesWithUrl:(NSString *)url
             andParameters:(NSDictionary *)parameters
                imageArray:(NSArray *)imageArray
              andImageName:(NSString *)imageName
          andInterfaceName:(NSString *)interfaceName
            withCompletion:(completion) completed;




@end
