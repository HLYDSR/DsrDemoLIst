//
//  HttpUpLoadImageViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "HttpUpLoadImageViewController.h"

@interface HttpUpLoadImageViewController ()

@end

@implementation HttpUpLoadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)uploadOneImageAction:(id)sender {
        NSDictionary *parameters =[[NSDictionary alloc] initWithObjectsAndKeys:@"38",@"member_id", nil];
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *imagePath = [mainBundle pathForResource:@"logo" ofType:@"jpg"];
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
        [SharedAction upLoadOneImageWithUrl:@"http://120.24.223.144:8080/index.php/api/Member/uploadHeadPortrait" andParameters:parameters andImage:image andImageName:@"head_portrait" andInterfaceName:@"head_portrait" withCompletion:^(BOOL complete,NSDictionary *info){
    
            NSLog(@"%@",info);
        }];
}

- (IBAction)upLoadImagesAction:(id)sender {
    NSDictionary *parameters =[[NSDictionary alloc] initWithObjectsAndKeys:@"38",@"member_id", nil];
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *imagePath = [mainBundle pathForResource:@"logo" ofType:@"jpg"];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
    //    UIImage *image=[UIImage imageNamed:@"logo"];
    NSArray *imageArray =@[image,image,image];
    [SharedAction upLoadImagesWithUrl:@"http://120.24.223.144:8080/index.php/api/Member/setPhotoToAlbum" andParameters:parameters imageArray:imageArray andImageName:@"photo" andInterfaceName:@"photo" withCompletion:^(BOOL complete,NSDictionary *info){
        NSLog(@"%@",info);
    }];
}
@end
