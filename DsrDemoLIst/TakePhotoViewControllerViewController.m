//
//  TakePhotoViewControllerViewController.m
//  EClub
//
//  Created by DengShiru on 14-12-5.
//  Copyright (c) 2014年 hlyclub. All rights reserved.
//

#import "TakePhotoViewControllerViewController.h"
#import "ChoosenImageCell.h"
#import <ELCImagePickerController.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>
@interface TakePhotoViewControllerViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ELCImagePickerControllerDelegate>
@end
@implementation TakePhotoViewControllerViewController

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupCollectionview];
}

-(void)setupCollectionview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(61, 61);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10.0f;
    layout.minimumLineSpacing = 10.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview.collectionViewLayout = layout;
    self.chooseImages = [NSMutableArray arrayWithObject:[UIImage imageNamed:@"bg_uploadimage_addimage_takephoto.png"]];
}

#pragma UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex==1){
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
        elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
        elcPicker.imagePickerDelegate = self;
        [self presentViewController:elcPicker animated:YES completion:nil];
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [self insertImage:image toChooseImages:self.chooseImages withUpdateCollectionView:self.collectionview];
                } else {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            }else {
                NSLog(@"Uknown asset type");
            }
        }
    }];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = nil;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^(void){
        [self insertImage:image toChooseImages:self.chooseImages withUpdateCollectionView:self.collectionview];
    }];
}

#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.chooseImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChoosenImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChoosenImageCell" forIndexPath:indexPath];
    cell.imgView.image = self.chooseImages[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.chooseImages.count-1) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [action showInView:self.view.window];
    }
}

-(void)insertImage:(UIImage *)image toChooseImages:(NSMutableArray *)images withUpdateCollectionView:(UICollectionView *)collectionView{
    [images insertObject:image atIndex:self.chooseImages.count-1];
    NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:images.count-2 inSection:0]];
    [collectionView insertItemsAtIndexPaths:array];
}

@end
