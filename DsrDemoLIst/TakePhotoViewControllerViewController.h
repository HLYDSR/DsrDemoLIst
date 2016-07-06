//
//  TakePhotoViewControllerViewController.h
//  EClub
//
//  Created by DengShiru on 14-12-5.
//  Copyright (c) 2014年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewControllerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property(nonatomic,strong)NSMutableArray *chooseImages;
@end
