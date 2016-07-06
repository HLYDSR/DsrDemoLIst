//
//  HorizontalViewController.h
//  LewPhotoBrowser
//
//  Created by pljhonglu on 15/5/19.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UserDetailViewController.h"

@interface MyselfHorizontalViewController : UIViewController
@property (nonatomic, weak)IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (nonatomic,strong) UIViewController *fatherController;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSMutableArray *images;
@end
