//
//  PickViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "PickViewController.h"
#import "DsrMainScrollView.h"
#define DeviceFrame [UIScreen mainScreen].bounds
@interface PickViewController ()
{
    UIView *views;
    UIButton *messagebtn;
    UIButton *friendbtn;
}
@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    views =[[UIView alloc] initWithFrame:CGRectMake((DeviceFrame.size.width-200)/2, 0, 200, 44)];
    views.backgroundColor=[UIColor clearColor];
    messagebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [messagebtn setTitle:@"消息" forState:UIControlStateNormal];
    [messagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [messagebtn setBackgroundColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000]];
    [messagebtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    messagebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    messagebtn.frame=CGRectMake(30, 5, 60, 28);
    [messagebtn.layer setCornerRadius:14];
    [views addSubview:messagebtn];
    
    friendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [friendbtn setTitle:@"朋友" forState:UIControlStateNormal];
    [friendbtn setTitleColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000] forState:UIControlStateNormal];
    [friendbtn setBackgroundColor:[UIColor clearColor]];
    friendbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [friendbtn addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    friendbtn.frame=CGRectMake(90, 5, 60, 28);
    [friendbtn.layer setCornerRadius:14];
    [views addSubview:friendbtn];
    [self setScrollView];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [views removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:views];
    
}
-(void)setScrollView{
    
    DsrMainScrollView *dsrScrollview =[[DsrMainScrollView alloc] initWithFrame:CGRectMake(0, 64, DeviceFrame.size.width, DeviceFrame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-16)];
    dsrScrollview.delegates=self;
    UIViewController *vic1=[[UIViewController alloc] init];
    vic1.view.backgroundColor=[UIColor redColor];
    UIViewController *vic2 =[[UIViewController alloc] init];
    vic2.view.backgroundColor=[UIColor yellowColor];
    
    [dsrScrollview initWithViewControllers:@[vic1,vic2]];
    dsrScrollview.scrollEnabled=YES;
    [self.view addSubview:dsrScrollview];
//    [self.view insertSubview:dsrScrollview atIndex:1];
}

-(void)messageAction{
    [messagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [messagebtn setBackgroundColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000]];
    [friendbtn setTitleColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000] forState:UIControlStateNormal];
    [friendbtn setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"first",@"scrollIndex",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
}

-(void)friendAction{
    [messagebtn setTitleColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000] forState:UIControlStateNormal];
    [messagebtn setBackgroundColor:[UIColor clearColor]];
    [friendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [friendbtn setBackgroundColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000]];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"second",@"scrollIndex",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didSelectedLocalImageAtIndex:(NSInteger)index{
    
}
-(void)selectIndex:(NSInteger)index{
    if (index==0) {
        [messagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [messagebtn setBackgroundColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000]];
        [friendbtn setTitleColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000] forState:UIControlStateNormal];
        [friendbtn setBackgroundColor:[UIColor clearColor]];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"first",@"scrollIndex",nil];
        NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        
    }else{
        [messagebtn setTitleColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000] forState:UIControlStateNormal];
        [messagebtn setBackgroundColor:[UIColor clearColor]];
        [friendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [friendbtn setBackgroundColor:[UIColor colorWithRed:0.984 green:0.353 blue:0.376 alpha:1.000]];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"second",@"scrollIndex",nil];
        NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    
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
