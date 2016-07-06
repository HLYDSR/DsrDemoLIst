//
//  DSRFloatButton.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSRFloatButtonDelegate <NSObject>
-(void)buttonTouchAction;

@end

@interface DSRFloatButton : UIButton
+(DSRFloatButton *)loadFromNibWithFrame:(CGRect)frame addTarget:(id)target InSuperView:(UIView *)superView;
-(void)showInFatherView:(UIView *)fatherView;
@property(nonatomic,strong)UIView *fatherView;
@property(nonatomic,strong)id<DSRFloatButtonDelegate> floatButtonDelegate;
@end
