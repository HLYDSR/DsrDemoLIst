//
//  ProgressShowController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "ProgressShowController.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface ProgressShowController ()

@end

@implementation ProgressShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect frame = CGRectMake(100, 200, 50, 50);
    MDRadialProgressView *radialView = [self progressViewWithFrame:frame];
    radialView.progressTotal = 100;
    radialView.progressCounter = 44;
    radialView.theme.sliceDividerHidden = YES;
    [self.view addSubview:radialView];
}
- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
    
    // Only required in this demo to align vertically the progress views.
    view.center = CGPointMake(self.view.center.x , view.center.y);
    
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
