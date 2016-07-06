//
//  AdViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "AdViewController.h"
#import "DSRScrollView.h"
@interface AdViewController ()<DSRScrollViewNetDelegate>

@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DSRScrollView *dsrNetScrollView = [[DSRScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 149)];
    /** 获取网络图片的index*/
    dsrNetScrollView.netDelagate = self;
    /** 设置滚动延时*/
    [dsrNetScrollView setImageWithNetImages:@[@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg"]];
    dsrNetScrollView.AutoScrollDelay = 3;
    /** 设置占位图*/
    dsrNetScrollView.placeholderImage = [UIImage imageNamed:@"pic_banner"];
    [self.view addSubview:dsrNetScrollView];
//    cell.backgroundColor=[UIColor blueColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didSelectedNetImageAtIndex:(NSInteger)index{


}

@end
