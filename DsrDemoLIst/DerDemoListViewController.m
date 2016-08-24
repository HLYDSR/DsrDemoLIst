//
//  ViewController.m
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "DerDemoListViewController.h"
#import "TouchIdViewController.h"
#import "TakePhotoViewControllerViewController.h"
#import "MyselfHorizontalViewController.h"
#import "ClearCacheViewController.h"
#import "StarViewDemoViewController.h"
#import "PickerDemoViewController.h"
#import "ZBarSDKDemoViewController.h"
#import "ListViewCell.h"
#import "RotateViewController.h"
#import "RecursionViewController.h"
#import "YADNewAddressViewController.h"
#import "UIButtonViewController.h"
#import "BIDViewController.h"
#import "WelcomeViewController.h"
#import "TextSendKeyboardViewController.h"
#import "ProgressShowController.h"
#import "TableviewMutiSelectViewController.h"
@interface DerDemoListViewController ()<ClearCacheDelegate>
{
    NSArray *listNameArray;
    ListViewCell *selcetCell;
    NSString *APPID;
}
@end

@implementation DerDemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listNameArray=@[@"指纹识别",@"ScrollView分页",@"悬浮按钮",@"通讯录",@"图片上传",@"索引",@"拍照",@"清理缓存",@"照片墙",@"评论APP",@"广告轮播",@"滑动视图",@"效果1",@"打分评价",@"选择器 禁止系统右滑手势",@"ZBar扫一扫",@"递归锁",@"从图库中选择多张照片",@"选转按钮",@"用runtime解决Button重复点击",@"省市区三级连滚",@"仿QQ搜索",@"欢迎页面",@"显示进度",@"文字发送键盘",@"tablview多选" ];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.textLabel.text = listNameArray[row];
    cell.detaile.text=@"";
    if (row==7) {
        cell.detaile.text=[self fileSizeToString:[self filePath]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UIViewController *target = nil;
    ClearCacheViewController *targets;
    MyselfHorizontalViewController *vc;
    NSString *identifier = nil;
    NSString *nibName = nil;
    if (row==0) {
        identifier = @"TouchIdViewController";
    }else if(row==1){
        identifier = @"ScrollPageViewController";
    }else if(row==2){
        identifier = @"FloatButtonViewController";
    }else if(row==3){
        identifier = @"ContactsViewController";
    }else if(row==4){
        identifier = @"HttpUpLoadImageViewController";
    }else if(row==5){
        identifier = @"TestTableViewController";
    }else if(row==6){
        identifier = @"MLMutiImagesChooseViewController";
//    nibName = @"TakePhotoViewControllerViewController";
//    target = [[TakePhotoViewControllerViewController alloc] initWithNibName:nibName bundle:nil];
    }else if (row==7){
        identifier = @"ClearCacheViewController";
    }else if (row==8){
     vc= [[MyselfHorizontalViewController alloc]init];
    if (vc.images==nil) {
        vc.images=[NSMutableArray new];
    }
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSMutableArray *imagearray =[NSMutableArray new];
    for (int i=1; i<10; i++) {
        NSString *imagePath = [mainBundle pathForResource:@"logo" ofType:@"jpg"];
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
        [imagearray insertObject:image atIndex:0];
    }
        
    [vc.images addObjectsFromArray:imagearray];
    [vc.collectionView reloadData];
    vc.fatherController=self;
    [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if (row==9){
        [self goToAppStore];
        return;
    }else if (row==10){
        identifier=@"AdViewController";
    }else if (row==11){
        identifier=@"PickViewController";
    }else if (row==12){
        identifier=@"CAVViewController";
    }else if (row==13){
        target = [[StarViewDemoViewController alloc] initWithNibName:@"StarViewDemoViewController" bundle:nil];
    }else if (row==14){
        target = [[PickerDemoViewController alloc] initWithNibName:@"PickerDemoViewController" bundle:nil];
    }else if(row==15){
        target = [[ZBarSDKDemoViewController alloc] initWithNibName:@"ZBarSDKDemoViewController" bundle:nil];
    }else if (row==16){
        target=[[RecursionViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==17){
        identifier=@"ChooseImagesViewController";
    }else if (row==18){
        target=[[RotateViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==19){
        target=[[UIButtonViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==20){
        target=[[YADNewAddressViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==21){
        identifier=@"BIDViewController";
    }else if (row==22){
        target=[[WelcomeViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==23){
        target=[[ProgressShowController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==24){
        target=[[TextSendKeyboardViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }else if (row==25){
        target=[[TableviewMutiSelectViewController alloc] init];
        [self.navigationController pushViewController:target animated:YES];
        return;
    }
    
    
    
    
    if (identifier!=nil) {
    target= [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    if (row==7) {
            targets = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
            targets.delegate=self;
            selcetCell =[tableView cellForRowAtIndexPath:indexPath];
            [self.navigationController pushViewController:targets animated:YES];
            return;
        }
    }
    [self.navigationController pushViewController:target animated:YES];
}
- (void)goToAppStore
{
    NSString *urlStr = [self getAppStroeUrlForiPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

-(NSString *)getAppStroeUrlForiPhone{
    return [NSString stringWithFormat:@"itmss://itunes.apple.com/us/app/wu-xian-ai/id%@?mt=8",APPID];
}
-(NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"0 B";
        
    }else if (fileSize < KB)
    {
        return @"< 1 KB";
        
    }else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
        
    }else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}


// 显示缓存大小
-( long long )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- ( long long ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize;
}


-(void)changeSizeInCell:(NSString *)size
{
    selcetCell.detailTextLabel.text=size;
}

@end
