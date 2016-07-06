//
//  ScrollPageViewController.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DsrPageScrollView.h"

@interface ScrollPageViewController : UIViewController<DsrPageScrollViewDelegate>
@property (weak, nonatomic) IBOutlet DsrPageScrollView *pageViews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heights;
@end
