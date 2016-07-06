//
//  
//  MEUProject
//
//  Created by DengShiru on 16/5/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol User_PhotoModel <NSObject>



@end
@interface User_PhotoModel : JSONModel
@property (nonatomic,strong) NSString <Optional>*picture;
@property (nonatomic,strong) NSNumber <Optional>*photo_id;
 

@end
