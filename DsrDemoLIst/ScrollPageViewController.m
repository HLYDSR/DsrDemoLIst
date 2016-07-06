//
//  ScrollPageViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "ScrollPageViewController.h"

@interface ScrollPageViewController ()
@end

@implementation ScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置图片url
    self.pageViews.imageType = UIImageUrlType;//传入image的方式（必填）
    self.pageViews.imgUrls = [NSArray arrayWithObjects:@"testImg1.png",@"testImg1.png",@"http://gtms04.alicdn.com/tps/i4/TB10SpoGFXXXXXbapXXvKyzTVXX-520-280.jpg", @"http://gtms04.alicdn.com/tps/i4/TB10SpoGFXXXXXbapXXvKyzTVXX-520-280.jpg",nil];//（必填）
    self.pageViews.titles = [NSArray arrayWithObjects:@"1",@"2",@"3", @"4",nil];//设置图片对应的title（可选）
    self.pageViews.dsrPageScrollViewDelegate = self;//（必填）
    self.pageViews.height = self.heights.constant;//（必填）
    self.pageViews.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
    self.pageViews.isAutoScroll = YES;//默认是NO（可选）
    self.pageViews.titleIsHidden = NO;//默认为NO（可选）
    self.pageViews.pageViewType = DsrScrollViewAdvertiseMode;//默认是广告模式（可选）
    [self.pageViews updatePageViewInFatherController:self];//（必填）//位置置于后面
    self.pageViews.defaultLocationIndex = 2;//这一步必须放在最后。（可选）

}

#pragma MartinLiPageScrollViewDelegate
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array{
    NSLog(@"%ld",(long)index);
}
@end
