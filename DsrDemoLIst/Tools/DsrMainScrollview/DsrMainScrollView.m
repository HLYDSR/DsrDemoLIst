//
//  DsrMainScrollView.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "DsrMainScrollView.h"

@implementation DsrMainScrollView
{
    NSInteger		previousPage;
    NSInteger		sessionCurrentPage;
    NSInteger		sessionNextPage;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollAction:) name:@"ScrollNow" object:nil];
        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
//        self.backgroundColor = [UIColor redColor];
        self.delegate=self;
        self.pagingEnabled=YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        _isScrollParallaxed = YES;
    }
    return self;
}

-(void)initWithViewControllers:(NSArray *)aControllers {
    self.controllers = aControllers;
    [self adjustControllerLayout];
}

- (void) adjustControllerLayout {
    CGRect scrollViewFrame = CGRectZero;
    scrollViewFrame = self.frame;
    self.frame = scrollViewFrame;
    self.contentSize = CGSizeMake( _controllers.count*CGRectGetWidth(scrollViewFrame), 10);
}

#pragma mark - ScrollView Events -
-(void)scrollAction:(NSNotification *)noti{
    if ([noti.userInfo[@"scrollIndex"] isEqualToString:@"first"]){
        previousPage=0;
    }else if([noti.userInfo[@"scrollIndex"] isEqualToString:@"second"]){
        previousPage=1;
    }else if([noti.userInfo[@"scrollIndex"] isEqualToString:@"third"]){
        previousPage=2;
    }else{
        previousPage=3;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, DeviceFrame.size.width, self.frame.size.height);
    [self scrollRectToVisible:CGRectMake(DeviceFrame.size.width*(previousPage), 0.0f,DeviceFrame.size.width, self.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    [self.delegates selectIndex:page];

//    scrollView.scrollEnabled=NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    [self.delegates selectIndex:page];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)setControllers:(NSArray *)aControllers {
    if ([_controllers isEqualToArray:aControllers]) return;
    [_controllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _controllers = aControllers;
    [self adjustScrollViewSubviewsFrames];
    previousPage = self.currentPage;
}

#pragma mark - Layout Routines -
- (void) adjustScrollViewSubviewsFrames {
   
    for (NSUInteger idx = 0; idx < _controllers.count; ++idx) {
        UIViewController *cViewController = _controllers[idx];
        CGRect cViewControllerFrame;
        
        if (idx==0) {
            cViewControllerFrame = CGRectMake((idx*CGRectGetWidth(self.frame)), self.topFrame-64,DeviceFrame.size.width, self.frame.size.height);
        }else{
            cViewControllerFrame = CGRectMake((idx*CGRectGetWidth(self.frame)), -64,DeviceFrame.size.width, self.frame.size.height);
        }
            cViewController.view.frame = cViewControllerFrame;
        [self addSubview:cViewController.view];
    }
}

@end
