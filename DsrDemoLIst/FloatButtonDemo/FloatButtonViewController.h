//
//  FloatButtonViewController.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatButtonViewController : UIViewController
- (IBAction)alertAction:(id)sender;
- (IBAction)pickViewAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pick;

@end
