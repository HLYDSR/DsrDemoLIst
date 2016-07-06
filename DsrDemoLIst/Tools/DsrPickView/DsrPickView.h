//
//  DsrPickView.h
//  MEUProject
//
//  Created by DengShiru on 16/4/20.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DsrPickView;

typedef void (^DsrPickViewBlock)(DsrPickView *view,UIButton *btn,NSString *sting);
typedef enum : NSUInteger {
    height=1,//身高
    date,//日期选择
    sex,//性别
    weight,//体重
    status,//状态
    shaiXuanStatus,//筛选状态
    shaiXuanHeight,//筛选 身高
    shaiXuanWeight,//筛选 体重
} pickType;
@interface DsrPickView : UIView

@property (copy, nonatomic)DsrPickViewBlock block;
-(void)setDataSouce:(NSArray *)dataSouce;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (assign,nonatomic)NSInteger pickType;
- (void)show;
@end
