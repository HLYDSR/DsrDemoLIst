//
//  UIButtonViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "UIButtonViewController.h"
#import "UIControl+HCDControlCategory.h"
@interface UIButtonViewController ()

@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(100, 100, 30, 30);
    tempBtn.backgroundColor = [UIColor greenColor];
//    tempBtn
    [tempBtn addTarget:self action:@selector(clickActionWithInterval:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.uxy_acceptEventInterval = 2.5;
    
    [self.view addSubview:tempBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 这里其实就是调用我们自定义的那个方法。
-(void)clickActionWithInterval:(UIButton *)sender{
    NSLog(@"你点 你点 点你大爷。");
}


@end
