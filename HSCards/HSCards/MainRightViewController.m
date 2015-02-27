//
//  MainRightViewController.m
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainRightViewController.h"
#import "ArrayDataSource.h"
#import "FilterListCell.h"
#import "CommonDefine.h"

#define FilterTableCellIdentifier @"FilterTableCell"

@interface MainRightViewController ()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@end

@implementation MainRightViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:1 blue:1 alpha:1.0];
    TableViewCellConfigureBlock configureCell = ^(FilterListCell* cell, NSDictionary* data) {
        [cell clearData];
        [cell loadCellData:data];
    };
    self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:FilterTableCellIdentifier configureCellBlock:configureCell];
    
    //_mainTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - SlidingAnchorLeftRevealAmount, 64, SlidingAnchorLeftRevealAmount, self.view.bounds.size.height - 64)];
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SlidingAnchorLeftRevealAmount, self.view.bounds.size.height)];
    DLog(@" _mainTable.frame.size.width = %f", _mainTable.frame.size.width);
    _mainTable.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:1 alpha:1.0];
    _mainTable.rowHeight = 60;
    [_mainTable registerClass:[FilterListCell class] forCellReuseIdentifier:FilterTableCellIdentifier];
    _mainTable.dataSource = self.arrayDataSource;
    _mainTable.delegate = self;
    [self.view addSubview:_mainTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.arrayDataSource appendWithItems:@[@{@"title":@"消耗"}]];
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"---------------didSelectRowAtIndexPath------------------");
    UIViewController* secondController = [[UIViewController alloc] init];
    secondController.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:secondController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
