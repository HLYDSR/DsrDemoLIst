//
//  TestTableViewController.m
//  UpdateImages
//
//  Created by DengShiru on 16/7/4.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "TestTableViewController.h"
#import "TableViewCell2.h"
@interface TestTableViewController ()
@property NSMutableArray * dataSource, * dataBase;
@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    searchBar.translucent = YES;
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    searchBar.showsCancelButton = YES;
    [searchBar sizeToFit];
    [self.tableView setTableHeaderView:searchBar];
    
    //改变索引的颜色
    self.tableView.sectionIndexColor = [UIColor blueColor];
    //改变索引选中的背景颜色
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor grayColor];
    
    //索引数组
    _dataSource = [[NSMutableArray alloc] init] ;
    
    //tableview 数据源
    _dataBase = [[NSMutableArray alloc] init] ;
    
    //初始化数据
    for(char c = 'A'; c <= 'Z'; c++ )
    {
        [_dataSource addObject:[NSString stringWithFormat:@"%c",c]];
        [_dataBase addObject:[NSString stringWithFormat:@"%c",c]];
        [_dataBase addObject:[NSString stringWithFormat:@"%c",c]];
        [_dataBase addObject:[NSString stringWithFormat:@"%c",c]];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    
    
    //取消选中的cell
    NSArray * indexPaths = [self.tableView indexPathsForSelectedRows];
    
    for(NSIndexPath * indexPath in indexPaths)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _dataSource;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    
    NSLog(@"%@-%ld",title,(long)index);
    
    for(NSString *character in _dataSource)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}


//返回section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [_dataSource count];
}

//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataSource objectAtIndex:section];
}

//返回每个section的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}


//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
    TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell2" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[TableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell2"];
    }
    
    cell.textLabel.text = [_dataBase objectAtIndex:indexPath.section * 3 + indexPath.row];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
