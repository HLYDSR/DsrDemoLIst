//
//  clearCacheViewController.h
//  MagicCurtain
//
//  Created by DengShiru on 16/4/7.
//  Copyright © 2016年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ClearCacheDelegate <NSObject>
-(void)changeSizeInCell:(NSString *)size;
@end
@interface ClearCacheViewController : UIViewController
@property (weak,nonatomic)id<ClearCacheDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *size;
- (IBAction)cleanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *free;
@property (weak, nonatomic) IBOutlet UILabel *baibu;

@end
