//
//  DsrMainScrollView.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DeviceFrame [UIScreen mainScreen].bounds
@protocol DsrMainScrollViewDelegate<NSObject>
-(void)selectIndex:(NSInteger)index;
@end
@interface DsrMainScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;
@property (nonatomic,assign)	BOOL			isScrollParallaxed;		// YES to add parallax effect while dragging pages
@property (nonatomic,retain)	NSArray			*controllers;
@property (nonatomic,assign)CGFloat topFrame;
@property (nonatomic,weak)id <DsrMainScrollViewDelegate>delegates;
- (void) adjustControllerLayout ;
-(void)initWithViewControllers:(NSArray *)aControllers;
@end
