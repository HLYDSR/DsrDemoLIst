//
//  CardView.h
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLCardView.h"
@protocol CardViewdelegate<NSObject>
-(void)changeOne;
-(void)guanzhu:(NSString *)memberId;
@end

@interface CardView : YSLCardView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIImageView *sexImageView;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UIButton *guanzhu;
@property (nonatomic, weak)id<CardViewdelegate>delegate;
@end
