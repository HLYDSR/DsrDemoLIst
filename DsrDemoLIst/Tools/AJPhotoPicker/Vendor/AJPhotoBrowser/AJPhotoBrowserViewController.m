//
//  AJPhotoBrowserViewController.m
//  AJPhotoBrowser
//
//  Created by AlienJunX on 16/2/15.
//  Copyright (c) 2015 AlienJunX
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "AJPhotoBrowserViewController.h"
#import "AJPhotoZoomingScrollView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIImageView+WebCache.h>
#import "Masonry.h"
#import "MemberInfo_PhotoModel.h"
@interface AJPhotoBrowserViewController()<UIScrollViewDelegate,UIActionSheetDelegate>
{
    //data
    NSInteger _currentPageIndex;
    NSMutableArray *_photos;
    //views
    UIScrollView *_photoScrollView;
    
    //Paging & layout
    NSMutableSet *_visiblePhotoViews,*_reusablePhotoViews;
}
@end

@implementation AJPhotoBrowserViewController

#pragma mark - init

- (instancetype)initWithPhotos:(NSArray *)photos {
    self = [super init];
    if (self) {
        [self commonInit];
        _currentPageIndex = 0;
        [_photos addObjectsFromArray:photos];
    }
    return self;
}

- (instancetype)initWithPhotos:(NSArray *)photos index:(NSInteger)index {
    self = [super init];
    if (self) {
        [self commonInit];
        _currentPageIndex = index;
        if (index < 0)
            _currentPageIndex = 0;
        if (index > photos.count-1)
            _currentPageIndex = photos.count - 1;
        
        [_photos addObjectsFromArray:photos];
    }
    return self;
}

- (void)commonInit {
    _visiblePhotoViews = [[NSMutableSet alloc] init];
    _reusablePhotoViews = [[NSMutableSet alloc] init];
    _photos = [[NSMutableArray alloc] init];
}
- (BOOL)prefersStatusBarHidden
{

    return YES;
}
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.clipsToBounds = YES;
    //initUI
    [self initUI];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self showPhotos];
   
    //显示指定索引
    _photoScrollView.contentOffset = CGPointMake(_currentPageIndex * _photoScrollView.bounds.size.width, 0);
    NSString *title = [NSString stringWithFormat:@"%lu / %lu",_currentPageIndex+1,(unsigned long)_photos.count];
    self.title = title;
}

- (void)initUI {
    //photoScrollview
    CGRect frame = self.view.bounds;
    _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    _photoScrollView.pagingEnabled = YES;
    _photoScrollView.delegate = self;
    _photoScrollView.showsHorizontalScrollIndicator = NO;
    _photoScrollView.showsVerticalScrollIndicator = NO;
    _photoScrollView.backgroundColor = UIColor.clearColor;
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
    [self.view addSubview:_photoScrollView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction:)];
    [_photoScrollView addGestureRecognizer:tap];
    
    if(self.type==1){
    UIBarButtonItem*barbutton=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(delBtnAction:)];
    barbutton.tintColor=[UIColor redColor];
    self.navigationItem.rightBarButtonItem=barbutton;
    }
}

//开始显示
- (void)showPhotos {
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
    NSInteger firstIndex = floor((CGRectGetMinX(visibleBounds)) / CGRectGetWidth(visibleBounds));
    NSInteger lastIndex  = floor((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    if (firstIndex >= _photos.count) {
        firstIndex = _photos.count - 1;
    }
    if (lastIndex < 0){
        lastIndex = 0;
    }
    if (lastIndex >= _photos.count) {
        lastIndex = _photos.count - 1;
    }
    
    // 回收不再显示的ImageView
    NSInteger photoViewIndex = 0;
    for (AJPhotoZoomingScrollView *photoView in _visiblePhotoViews) {
        photoViewIndex = photoView.tag-100;
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
            [_reusablePhotoViews addObject:photoView];
            [photoView prepareForReuse];
            [photoView removeFromSuperview];
        }
    }
    
    [_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
    
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isShowingPhotoViewAtIndex:index]) {
            [self showPhotoViewAtIndex:index];
        }
    }
}

//显示指定索引的图片
- (void)showPhotoViewAtIndex:(NSInteger)index {
    AJPhotoZoomingScrollView *photoView = [self dequeueReusablePhotoView];
    if (photoView == nil) {
        photoView = [[AJPhotoZoomingScrollView alloc] init];
    }
    //显示大小处理
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.origin.x = bounds.size.width * index;
    photoView.tag = 100 + index;
    photoView.frame = photoViewFrame;
    //显示照片处理
    UIImage *photo = nil;
    UIImageView *imageView =[UIImageView new];
    
    id photoObj = _photos[index];
    if ([photoObj isKindOfClass:[UIImage class]]) {
        photo = photoObj;
    } else if ([photoObj isKindOfClass:[ALAsset class]]) {
        CGImageRef fullScreenImageRef = ((ALAsset *)photoObj).defaultRepresentation.fullScreenImage;
        photo = [UIImage imageWithCGImage:fullScreenImageRef];
    }else{
        MemberInfo_PhotoModel *model =_photos[index];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.223.144:8080/static/%@",model.picture]] placeholderImage:nil];
        photo=imageView.image;

    }
    [photoView setShowImage:photo];
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
}

//获取可重用的view
- (AJPhotoZoomingScrollView *)dequeueReusablePhotoView {
    AJPhotoZoomingScrollView *photoView = [_reusablePhotoViews anyObject];
    if (photoView) {
        [_reusablePhotoViews removeObject:photoView];
    }
    return photoView;
}

//判断是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSInteger)index {
    for (AJPhotoZoomingScrollView* photoView in _visiblePhotoViews) {
        if ((photoView.tag - 100) == index) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Action
- (void)doneBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(photoBrowser:didDonePhotos:)]) {
        [_delegate photoBrowser:self didDonePhotos:_photos];
    }
}

- (void)delBtnAction:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    actionSheet.tag = 2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [_photos removeObjectAtIndex:_currentPageIndex];
       
        if (_delegate && [_delegate respondsToSelector:@selector(photoBrowser:deleteWithIndex:)]) {
            [_delegate photoBrowser:self deleteWithIndex:_currentPageIndex];
        }
        //reload;
        _currentPageIndex =_currentPageIndex-1;
        if (_currentPageIndex==-1 && _photos.count == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            _currentPageIndex = (_currentPageIndex == (-1) ? 0 : _currentPageIndex);
            if (_currentPageIndex == 0) {
                [self showPhotoViewAtIndex:0];
            } else {
                _photoScrollView.contentOffset = CGPointMake(_currentPageIndex * _photoScrollView.bounds.size.width, 0);
            }
            _photoScrollView.contentSize = CGSizeMake(_photoScrollView.bounds.size.width * _photos.count, 0);
        }
        NSString *title = [NSString stringWithFormat:@"%lu / %lu",_currentPageIndex+1,(unsigned long)_photos.count];
        self.title = title;

    }
}

#pragma mark - uiscrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showPhotos];
    int pageNum = floor((_photoScrollView.contentOffset.x - _photoScrollView.frame.size.width / (_photos.count+2)) / _photoScrollView.frame.size.width) + 1;
    _currentPageIndex = pageNum==_photos.count?pageNum-1:pageNum;
    [self setTitlePageInfo];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentPageIndex = floor((_photoScrollView.contentOffset.x - _photoScrollView.frame.size.width / (_photos.count+2)) / _photoScrollView.frame.size.width) + 1;
    [self setTitlePageInfo];
}

- (void)setTitlePageInfo {
    NSString *title = [NSString stringWithFormat:@"%lu / %lu",_currentPageIndex+1,(unsigned long)_photos.count];
    self.title = title;
}

- (void)dealloc {
    [_photos removeAllObjects];
    [_reusablePhotoViews removeAllObjects];
    [_visiblePhotoViews removeAllObjects];
}

-(void)imgTapAction:(UITapGestureRecognizer *)tap{
    if(self.navigationController.navigationBar.hidden==YES){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com