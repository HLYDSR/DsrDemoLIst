//
//  TouchIdViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "TouchIdViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface TouchIdViewController ()

@end

@implementation TouchIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchIdAction:(id)sender {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL succes, NSError *error) {
                                
                                //这里回到主线程，否则会在该界面停顿很久
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (succes) {
                                        
                                        NSLog(@"User is authenticated successfully");
                                    } else {
                                        
                                        switch (error.code) {
                                            case LAErrorAuthenticationFailed:
                                                NSLog(@"Authentication Failed");
                                                break;
                                                
                                            case LAErrorUserCancel:
                                                NSLog(@"User pressed Cancel button");
                                                break;
                                                
                                            case LAErrorUserFallback:
                                                NSLog(@"User pressed \"Enter Password\"");
                                                break;
                                                
                                            default:
                                                NSLog(@"Touch ID is not configured");
                                                break;
                                        }
                                        
                                        NSLog(@"Authentication Fails");
                                    }
                                    
                                });
                                
                                
                            }];
    } else {
        NSLog(@"Can not evaluate Touch ID");
        
    }

}
@end
