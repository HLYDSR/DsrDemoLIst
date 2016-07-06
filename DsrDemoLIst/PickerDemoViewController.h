//
//  PickerDemoViewController.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerDemoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *seletButton;
- (IBAction)selectAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectButton2;
- (IBAction)selectAction2:(id)sender;
@end
