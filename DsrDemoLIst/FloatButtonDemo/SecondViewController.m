//
//  SecondViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<DSRFloatButtonDelegate>
@end
@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.floatButton showInFatherView:self.view];
}

#pragma MLFloatButtonDelegate
-(void)buttonTouchAction{
    NSLog(@"SecondViewController floatButton touched");
}
@end
