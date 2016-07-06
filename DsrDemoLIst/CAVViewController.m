//
//  CAVViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "CAVViewController.h"
#import "CardView.h"
#import "YSLDraggableCardContainer.h"
#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]
@interface CAVViewController ()<YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource,CardViewdelegate>
@property (nonatomic, strong) YSLDraggableCardContainer *container;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation CAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
    [self.view addSubview:_container];

}
- (void)loadData
{
    [_datas removeAllObjects];
//    [index1Service getMemberRecommendWithSelfID:[NSString stringWithFormat:@"%@",user.id] andMax:@"10" withDone:^(GetMemberRecommendModel *model){
//        [_datas addObjectsFromArray:model.result_data];
//        [_container reloadCardContainer];
//    }];
}
#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
//    GetMemberRecommend_Result_dataModel *model = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 66, self.view.frame.size.width - 20, self.view.frame.size.height - 124)];
    view.delegate=self;
//    view.backgroundColor = [UIColor whiteColor];
//    [view.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseImageIP,model.head_portrait]] placeholderImage:nil];
//    view.label.text = model.nick_name;
//    if ([model.sex isEqual:@1]) {
//        view.sexImageView.image=[UIImage imageNamed:@"icon_pic_nan"];
//    }else{
//        view.sexImageView.image=[UIImage imageNamed:@"icon_pic_nv"];
//    }
//    if ([model.fans_type isEqualToString:@"fans_for_he"]) {
//        view.label2.text=@"取消关注";
//    }else{
//        view.label2.text=@"去关注";
//    }
//    
//    view.label3.text=[NSString stringWithFormat:@"%@、%@、%@",model.age,model.star_sign,model.last_online_time];
//    view.label4.text=[NSString stringWithFormat:@"状态: %@",model.status];
//    view.label5.text=model.desc;
//    view.guanzhu.tag=[model.member_id integerValue];
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

-(void)changeOne{
    int value = (arc4random() % 4) + 0;
    if (value == 0) {
        [_container movePositionWithDirection:YSLDraggableDirectionUp isAutomatic:YES];
    }
    if (value == 1) {
        [_container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES];
    }
    if (value == 2) {
        [_container movePositionWithDirection:YSLDraggableDirectionLeft isAutomatic:YES];
    }
    if (value == 3) {
        [_container movePositionWithDirection:YSLDraggableDirectionRight isAutomatic:YES];
    }
    
}

-(void)guanzhu:(NSString *)memberId {
    
//    [index1Service getfansWithSelf_id:[NSString stringWithFormat:@"%@",user.id] andMember_id:memberId withDone:^(GuanzhuModel *model){
//        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
//        [self changeOne];
//    }];
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
            draggableView:(UIView *)draggableView
       draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    CardView *view = (CardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        view.selectedView.backgroundColor = RGB(215, 104, 91);
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        view.selectedView.backgroundColor = RGB(114, 209, 142);
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        view.selectedView.backgroundColor = RGB(66, 172, 225);
        view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [self loadData];
    });
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
//    GetMemberRecommend_Result_dataModel *model =_datas[index];
//    [index0Service getMemberInfoWithSelf_id:[NSString stringWithFormat:@"%@",user.id] andMember_id:[NSString stringWithFormat:@"%@",model.member_id] withDone:^(MemberInfoModel *model){
//        UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
//        UserDetailViewController *userDetailViewController=[storyBoard instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
//        userDetailViewController.models=model.result_data;
//        userDetailViewController.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:userDetailViewController animated:YES];
//    }];
    NSLog(@"++ index : %ld",(long)index);
    
}


@end
