//
//  HorizontalViewController.m
//  LewPhotoBrowser
//
//  Created by pljhonglu on 15/5/19.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "MyselfHorizontalViewController.h"
#import "LewReorderableLayout.h"
#import "LewCollectionViewCell.h"
#import <ELCImagePickerController.h>
#import "MLImagesBrowserViewController.h"
#import "AJPhotoPickerViewController.h"
#import "AJPhotoBrowserViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIImageView+WebCache.h>
#import "User_PhotoModel.h"
//#import "Index3Service.h"
//#import "UserInfoModel.h"
//#import "StatusModel.h"
#define cellIdentifier @"LewCollectionViewCell"

@interface MyselfHorizontalViewController ()<LewReorderableLayoutDelegate, LewReorderableLayoutDataSource,AJPhotoPickerProtocol,AJPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos;
@end

@implementation MyselfHorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    LewReorderableLayout *layout = (LewReorderableLayout *)[_collectionView collectionViewLayout];
    layout.delegate = self;
    layout.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LewReorderableLayoutDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    LewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"icon_but_tiaojianzhaopian"];
    }else{
        if ([_images[indexPath.item-1] isKindOfClass:[UIImage class]]) {
            cell.imageView.image=_images[indexPath.item-1];
        }else{
         User_PhotoModel *model =_images[indexPath.item-1];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.223.144:8080/static/%@",model.picture]] placeholderImage:nil];
        }
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count+1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        AJPhotoPickerViewController *picker = [[AJPhotoPickerViewController alloc] init];
        picker.maximumNumberOfSelection = 15;
        picker.multipleSelection = YES;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups = YES;
        picker.delegate=self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return YES;
        }];
        [self.fatherController presentViewController:picker animated:YES completion:nil];

    }else{
        AJPhotoBrowserViewController *photoBrowserViewController = [[AJPhotoBrowserViewController alloc] initWithPhotos:_images index:indexPath.row-1];
        photoBrowserViewController.delegate = self;
        photoBrowserViewController.type=1;
        photoBrowserViewController.hidesBottomBarWhenPushed=YES;
        [self.fatherController.navigationController pushViewController:photoBrowserViewController animated:YES];
        
    }
}


-(void)choseImage:(UIImage *)image{

}
-(void)pushToTargate:(UIViewController *)targate{

}

#pragma mark - BoPhotoPickerProtocol
- (void)photoPickerDidCancel:(AJPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAssets:(NSArray *)assets {
    NSMutableArray *photoArray=[NSMutableArray new];
    [self.photos addObjectsFromArray:assets];
        for (int i = 0 ; i < assets.count; i++) {
            ALAsset *asset = assets[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [_images insertObject:tempImg atIndex:0];
            [photoArray addObject:tempImg];
        }
    __block MyselfHorizontalViewController *weekSelf=self;
    NSLog(@"选完之后在这里上传,空间有限 暂时不传");
    
    
//    [index3Service setPhotoToAlbumWithmember_id:[NSString stringWithFormat:@"%@",user.id] andPhoto:photoArray withDone:^(StatusModel *model){
//        [weekSelf.collectionView reloadData];
//        [picker dismissViewControllerAnimated:YES completion:nil];
//    }];
    
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAsset:(ALAsset *)asset {
    NSLog(@"%s",__func__);
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didDeselectAsset:(ALAsset *)asset {
    NSLog(@"%s",__func__);
}

//超过最大选择项时
- (void)photoPickerDidMaximum:(AJPhotoPickerViewController *)picker {
    NSLog(@"%s",__func__);
}

//低于最低选择项时
- (void)photoPickerDidMinimum:(AJPhotoPickerViewController *)picker {
    NSLog(@"%s",__func__);
}

- (void)photoPickerTapCameraAction:(AJPhotoPickerViewController *)picker {
    [self checkCameraAvailability:^(BOOL auth) {
        if (!auth) {
            NSLog(@"没有访问相机权限");
            return;
        }
        
        [picker dismissViewControllerAnimated:NO completion:nil];
        UIImagePickerController *cameraUI = [UIImagePickerController new];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        [self.fatherController presentViewController: cameraUI animated: YES completion:nil];
    }];
}

#pragma mark - AJPhotoBrowserDelegate

- (void)photoBrowser:(AJPhotoBrowserViewController *)vc deleteWithIndex:(NSInteger)index {
    
    NSLog(@"删除照片 %ld",index);
//     MemberInfo_PhotoModel *model =_images[index];
//    [index3Service deletePhotoToAlbumMemberID:[NSString stringWithFormat:@"%@",user.id] andPhoto_id:[NSString stringWithFormat:@"%@",model.photo_id] withDone:^(StatusModel *model){
        [_images removeObjectAtIndex:index];

        [self.collectionView reloadData];
//    }];
       NSLog(@"%s",__func__);
}

- (void)photoBrowser:(AJPhotoBrowserViewController *)vc didDonePhotos:(NSArray *)photos {
    NSLog(@"%s",__func__);
    [self.photos removeAllObjects];
    [self.photos addObjectsFromArray:photos];
    if (photos.count == 1) {
        ALAsset *asset = photos[0];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [_images insertObject:tempImg atIndex:0];
    } else {
        for (int i = 0 ; i < self.photos.count; i++) {
            ALAsset *asset = self.photos[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [_images insertObject:tempImg atIndex:0];
        }
    }
    [self.collectionView reloadData];
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)showBig:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    AJPhotoBrowserViewController *photoBrowserViewController = [[AJPhotoBrowserViewController alloc] initWithPhotos:self.photos index:index];
    photoBrowserViewController.delegate = self;
    [self.fatherController presentViewController:photoBrowserViewController animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (!error) {
        NSLog(@"保存到相册成功");
    }else{
        NSLog(@"保存到相册出错%@", error);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;
    if (CFStringCompare((CFStringRef) mediaType,kUTTypeImage, 0)== kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    __block MyselfHorizontalViewController *weekSelf=self;
    [_images insertObject:originalImage atIndex:0];
    NSLog(@"选择完毕");
    
//    [index3Service setPhotoToAlbumWithmember_id:[NSString stringWithFormat:@"%@",user.id] andPhoto:@[originalImage] withDone:^(StatusModel *model){
//        [weekSelf.collectionView reloadData];
//        [picker dismissViewControllerAnimated:YES completion:nil];
//    }];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)checkCameraAvailability:(void (^)(BOOL auth))block {
    BOOL status = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        status = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if (block) {
                    block(granted);
                }
            } else {
                if (block) {
                    block(granted);
                }
            }
        }];
        return;
    }
    if (block) {
        block(status);
    }
}

- (NSMutableArray *)photos {
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end
