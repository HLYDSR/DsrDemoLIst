//
//  DsrPickView.m
//  MEUProject
//
//  Created by DengShiru on 16/4/20.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "DsrPickView.h"

@interface DsrPickView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic,strong)NSArray *dataSouces;
@property (nonatomic,strong)NSString *detailString;
@property (nonatomic,strong)NSMutableArray *detailArray;;
@property (nonatomic,assign) NSInteger selectedYearRow;
@property (nonatomic,assign) NSInteger selectedMonthRow;
@property (nonatomic,assign) NSInteger selectedDayRow;
@end

@implementation DsrPickView

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"DsrPickView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        _detailArray=[NSMutableArray new];
       [self customView];
    }
    return self;
}

-(void)setDataSouce:(NSArray *)dataSouce{
    self.dataSouces=dataSouce;
    if ([self.dataSouces[0] isKindOfClass:[NSArray class]]) {
    if (_pickType==date) {
            NSArray *array =self.dataSouces[0];
            NSArray *array1 =self.dataSouces[1];
            NSArray *array2 =self.dataSouces[2];
            [_detailArray addObject:array[51]];
            [_detailArray addObject:array1[6]];
            [_detailArray addObject:array2[16]];
    }else if (_pickType==shaiXuanStatus) {
        NSArray *array =self.dataSouces[0];
        NSArray *array1 =self.dataSouces[1];
        [_detailArray addObject:array[0]];
        [_detailArray addObject:array1[array1.count-1]];
    } else if (_pickType==shaiXuanHeight||_pickType==shaiXuanWeight) {
        NSArray *array =self.dataSouces[0];
        NSArray *array1 =self.dataSouces[1];
        [_detailArray addObject:array[0]];
        [_detailArray addObject:array1[array1.count-1]];
    }else{
            for (int i=0;i<self.dataSouces.count;i++ ) {
                NSArray *array =self.dataSouces[i];
                [_detailArray addObject:array[0]];
            }
        }
    }else{
        if (_pickType==height) {
            [_detailArray addObject:dataSouce[65]];
        }else if (_pickType==weight) {
            [_detailArray addObject:dataSouce[34]];
        }else{
            [_detailArray addObject:dataSouce[0]];
        }
        }
    [self.pickView reloadAllComponents];
}

- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    if (self.block) {
        self.block(self,sender,[_detailArray componentsJoinedByString:@"-"]);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews firstObject];
    [topView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
    
    if (_pickType==date) {
        [self.pickView selectRow:51 inComponent:0 animated:YES];
        [self.pickView selectRow:6 inComponent:1 animated:YES];
        [self.pickView selectRow:16 inComponent:2 animated:YES];
    }
    if (_pickType==height) {
        [self.pickView selectRow:65 inComponent:0 animated:YES];
    }
    if (_pickType==weight) {
         [self.pickView selectRow:34 inComponent:0 animated:YES];
    }
    
    
    if (_pickType==shaiXuanHeight||_pickType==shaiXuanWeight) {
        NSArray *array1 =self.dataSouces[1];
        [self.pickView selectRow:0 inComponent:0 animated:YES];
        [self.pickView selectRow:array1.count-1 inComponent:1 animated:NO];
    }

    
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([self.dataSouces[0] isKindOfClass:[NSArray class]]) {
        return self.dataSouces.count;
    }else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickType==date) {
        if (component==0) {
            NSArray *array =self.dataSouces[component];
            return array.count;
        }else if(component==1){
            NSArray *array =self.dataSouces[component];
            return array.count;
        }else{
            NSArray *array =self.dataSouces[0];
            NSArray *array1 =self.dataSouces[1];
            return [self howManyDaysInThisMonth:[array[_selectedYearRow] intValue] month:[array1[_selectedMonthRow] intValue]];
        }
        
    }
    if ([self.dataSouces[component] isKindOfClass:[NSArray class]]) {
        NSArray *array =self.dataSouces[component];
        return array.count;
    }
    return self.dataSouces.count;
}

-(int)howManyDaysInThisMonth:(int)year month:(int)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.dataSouces[component] isKindOfClass:[NSArray class]]) {
        NSArray *array =self.dataSouces[component];
        if (self.pickType==shaiXuanHeight) {
            return [NSString stringWithFormat:@"%@ CM",array[row]];
        }
        if (self.pickType==shaiXuanWeight) {
            return [NSString stringWithFormat:@"%@ KG",array[row]];
        }
        
        return array[row];
    }
    if (self.pickType==height) {
        return [NSString stringWithFormat:@"%@ CM",self.dataSouces[row]];
    }
    if (self.pickType==weight) {
        return [NSString stringWithFormat:@"%@ KG",self.dataSouces[row]];
    }
        return self.dataSouces[row];
    
    
}
#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(_pickType==date){
        if (component == 0)
        {
            _selectedYearRow = (int)row;
            [self.pickView reloadAllComponents];
        }
        else if (component == 1)
        {
            _selectedMonthRow = (int)row;
            [self.pickView reloadAllComponents];
        }
    }
    if ([self.dataSouces[component] isKindOfClass:[NSArray class]]) {
    NSArray *array =self.dataSouces[component];
    [_detailArray replaceObjectAtIndex:component withObject:array[row]];
    }else{
     [_detailArray replaceObjectAtIndex:component withObject:self.dataSouces[row]];
    }
}


@end
