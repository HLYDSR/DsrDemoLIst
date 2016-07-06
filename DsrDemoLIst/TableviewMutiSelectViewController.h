//
//  TableviewMutiSelectViewController.h
//  DsrDemoLIst
//
//  Created by DengShiru on 16/7/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableviewMutiSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
