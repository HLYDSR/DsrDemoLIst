//
//  CardView.m
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor orangeColor];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [self addSubview:_imageView];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(7.0, 7.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
    
    _selectedView = [[UIView alloc]init];
    _selectedView.frame = _imageView.frame;
    _selectedView.backgroundColor = [UIColor clearColor];
    _selectedView.alpha = 0.0;
    [_imageView addSubview:_selectedView];
    
    UIButton *change =[UIButton buttonWithType:UIButtonTypeCustom];
    [change setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
    [change setImage:[UIImage imageNamed:@"change"] forState:UIControlStateHighlighted];
    [change addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    change.frame=CGRectMake(8, self.frame.size.width+5,(self.frame.size.width-100)/2+5 , 32);
    [self addSubview:change];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.backgroundColor = [UIColor clearColor];
    label1.text=@"换一个";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.frame = CGRectMake(10,self.frame.size.width+5 ,(self.frame.size.width-40)/2+5,30);
    label1.font = [UIFont fontWithName:@"Futura-Medium" size:17];
    [self addSubview:label1];
    
     _guanzhu=[UIButton buttonWithType:UIButtonTypeCustom];
    [_guanzhu setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
    [_guanzhu setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateHighlighted];
    _guanzhu.frame=CGRectMake((self.frame.size.width-100)/2 + 76, self.frame.size.width+5,(self.frame.size.width-100)/2 , 32);
    [_guanzhu addTarget:self action:@selector(guanzhuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_guanzhu];
     _label2= [[UILabel alloc]init];
    _label2.backgroundColor = [UIColor clearColor];
    _label2.text=@"关注";
    _label2.textAlignment=NSTextAlignmentCenter;
    _label2.frame = CGRectMake((self.frame.size.width-100)/2 + 80,self.frame.size.width+5 ,(self.frame.size.width-40)/2,30);
    _label2.font = [UIFont fontWithName:@"Futura-Medium" size:17];
    [self addSubview:_label2];
    
    UIView *viewsss =[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-10, self.frame.size.width+5, 1, 45)];
    viewsss.backgroundColor= [UIColor grayColor];
    [self addSubview:viewsss];
    
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height * 0.76,self.frame.size.width ,self.frame.size.height * 0.25)];
    view.backgroundColor=[UIColor colorWithWhite:0.918 alpha:1.000];
    [self addSubview:view];
    
     _sexImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 16, 16)];
    _sexImageView.image =[UIImage imageNamed:@"icon_pic_nan"];
    [view addSubview:_sexImageView];
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor clearColor];
    _label.frame = CGRectMake(10, 4, self.frame.size.width - 20, 20);
    _label.font = [UIFont fontWithName:@"Futura-Medium" size:15];
    [view addSubview:_label];

    _label3 = [[UILabel alloc]init];
    _label3.backgroundColor = [UIColor clearColor];
    _label3.frame = CGRectMake(30, 28, self.frame.size.width - 30, 20);
    _label3.text=@"26、巨蟹座、3小时前";
    _label3.textColor=[UIColor grayColor];
    _label3.font = [UIFont fontWithName:@"Futura-Medium" size:15];
    [view addSubview:_label3];
    
    _label4= [[UILabel alloc]init];
    _label4.backgroundColor = [UIColor clearColor];
    _label4.frame = CGRectMake(10, 50, self.frame.size.width - 30, 20);
    _label4.text=@"状态：单身";
    _label4.textColor=[UIColor grayColor];
    _label4.font = [UIFont fontWithName:@"Futura-Medium" size:14];
    [view addSubview:_label4];
    
    _label5 = [[UILabel alloc]init];
    _label5.textColor=[UIColor grayColor];
    _label5.backgroundColor = [UIColor clearColor];
    _label5.frame = CGRectMake(10, 74, self.frame.size.width - 30, 20);
    _label5.text=@"喜欢交朋友，寻找志同道合的伙伴";
    _label5.font = [UIFont fontWithName:@"Futura-Medium" size:14];
    [view addSubview:_label5];
}
-(void)guanzhuAction:(id)sender{
    if([_label2.text isEqualToString:@"已关注"]){
        return;
    }
    
    UIButton *btn =sender;
    NSString *tagString =[NSString stringWithFormat:@"%ld",(long)btn.tag];
    [self.delegate guanzhu:tagString];
}

-(void)changeAction{
    [self.delegate changeOne];
}
@end
