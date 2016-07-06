//
//  FloatButtonViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "FloatButtonViewController.h"
#import "DSRFloatButton.h"
#import "DXAlertView.h"
#import "DsrPickView.h"
#import "SecondViewController.h"
@interface FloatButtonViewController ()<DSRFloatButtonDelegate>
{
    DSRFloatButton *floatButton;
}
@end
@implementation FloatButtonViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    floatButton = [DSRFloatButton loadFromNibWithFrame:CGRectMake(100, 100, 32, 32) addTarget:self InSuperView:self.view];//这里一定要在viewWillAppear实现，否则，popBack将会看不到效果
 
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FloatButtonPush"]) {
        SecondViewController *target = segue.destinationViewController;
        target.floatButton = floatButton;
        target.floatButton.floatButtonDelegate = (id)target; //重新设置代理controller
    }
}

#pragma MLFloatButtonDelegate
-(void)buttonTouchAction{
    NSLog(@"button action");
}
- (IBAction)alertAction:(id)sender {
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"切换账号" contentText:@"退出当前账号，切换账号" leftButtonTitle:@"是" rightButtonTitle:@"否"];
    [alert show];
    alert.leftBlock = ^() {
       NSLog(@"left button clicked");
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };

}

- (IBAction)pickViewAction:(id)sender {
    DsrPickView *dsrpickView=[[DsrPickView alloc] init];
    __block FloatButtonViewController *blockSelf=self;

    dsrpickView.title.text=@"选择年龄";
    NSMutableArray *yearArray =[NSMutableArray new];
    for (int i = 1940; i <= 2016 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSArray *monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    NSMutableArray *daysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [daysArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    dsrpickView.pickType=date;
    [dsrpickView setDataSouce:@[yearArray,monthArray,daysArray]];
    dsrpickView.block=^(DsrPickView *view,UIButton *button,NSString *local){
        blockSelf.pick.titleLabel.text=local;
    };
    [dsrpickView show];
}
@end
