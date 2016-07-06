//
//  EMAlertView.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface EMAlertView : UIAlertView

/**
 *  弹出提示框
 *
 *  @param title             标题
 *  @param message           显示文字
 *  @param block             回调
 *  @param cancelButtonTitle 取消
 *  @param otherButtonTitles 其他
 *
 *  @return <#return value description#>
 */
+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               completionBlock:(void (^)(NSUInteger buttonIndex, EMAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
