//
//  DsrPageScrollView.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{
    DsrScrollViewAdvertiseMode,
    DsrPageScrollViewFullScreenMode
};

enum{
    UIImageUrlType,
    UIImageType
};

@protocol DsrPageScrollViewDelegate <NSObject>
@optional
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array;
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index;//不建议使用
@end

@interface DsrPageScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,assign)NSInteger pageViewType;
@property(nonatomic,assign)NSInteger imageType;//若imageType==UIImageUrlType，则传入imgUrls；否则传入images
@property(nonatomic,strong)NSArray *imgUrls;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *urls;
@property(nonatomic,assign)float height;
@property(nonatomic,assign)float timeInterval;
@property(nonatomic,weak)id<DsrPageScrollViewDelegate> dsrPageScrollViewDelegate;
@property(nonatomic,assign)NSInteger defaultLocationIndex;
@property(nonatomic)BOOL titleIsHidden;  //默认BOOL为NO
@property(nonatomic)BOOL isAutoScroll;  //默认为NO   自动滚动尚且存在问题，就是有时候不滚。
-(void)updatePageViewInSuperView:(UIView *)superView;//不建议使用
-(void)updatePageViewInFatherController:(UIViewController *)fatherController;//建议使用这个
@end
