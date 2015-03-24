//
//  MainLeftViewController.m
//  HSCards
//
//  Created by song jufeng on 15/3/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainLeftViewController.h"
#import "CommonDefine.h"
#import "ArrayDataSource.h"
#import "LeftMenuCell.h"
#define LeftMenuCellIdentifier @"LeftMenuCell"

@interface MainLeftViewController ()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@end

@implementation MainLeftViewController
- (void)loadView
{
    [super loadView];
    
    UIView* bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    bar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    TableViewCellConfigureBlock configureCell = ^(LeftMenuCell* cell, NSDictionary* data) {
        [cell clearData];
        [cell loadCellData:data];
    };
    self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:LeftMenuCellIdentifier configureCellBlock:configureCell];
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SlidingAnchorRightRevealAmount, self.view.bounds.size.height - 64)];
    self.mainTable.rowHeight = LeftMenu_Row_H;
    [self.mainTable registerClass:[LeftMenuCell class] forCellReuseIdentifier:LeftMenuCellIdentifier];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self.arrayDataSource;
    [self.view addSubview:self.mainTable];
    
    [self.arrayDataSource appendWithItems:@[@{@"title":@"Home",@"icon":@"menu_home"},
                                            @{@"title":@"Search",@"icon":@"menu_search"}]];
    [self.mainTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:1 alpha:1.0];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell  = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}

@end
