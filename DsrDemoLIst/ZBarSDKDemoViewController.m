//
//  ZBarSDKDemoViewController.m
//  EClub
//
//  Created by DengShiru on 14/7/4.
//  Copyright © 2014年 hlyclub. All rights reserved.
//

#import "ZBarSDKDemoViewController.h"
#import <ZBarSDK.h>

@interface ZBarSDKDemoViewController ()<ZBarReaderDelegate>

@end

@implementation ZBarSDKDemoViewController

- (IBAction)scanAction:(id)sender {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [self presentViewController:reader animated:YES completion:nil];
}

#pragma ZBarReaderDelegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSString *textd = symbol.data;
    //解决中文乱码问题
    if ([textd canBeConvertedToEncoding:NSShiftJISStringEncoding])
    {
        textd = [NSString stringWithCString:[textd cStringUsingEncoding:
                                             NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }
    self.info.text = textd;
    [reader dismissViewControllerAnimated:YES completion:nil];
}
@end
