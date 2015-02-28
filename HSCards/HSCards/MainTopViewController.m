//
//  MainTopViewController.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainTopViewController.h"
#import "ArrayDataSource.h"
#import "CardListCell.h"
#import "CardItemInfo.h"
#import "CardsBox.h"
#define CardListCellIdentifier @"CardListCell"

@interface MainTopViewController ()
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@end

@implementation MainTopViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.8 alpha:1.0];
    
    TableViewCellConfigureBlock configureCell = ^(CardListCell *cell, CardItemInfo *data) {
        [cell clearData];
        [cell loadCellData:data];
    };
    self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:CardListCellIdentifier configureCellBlock:configureCell];
    
    _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    _mainTable.rowHeight = MainList_Row_H;
    [_mainTable registerClass:[CardListCell class] forCellReuseIdentifier:CardListCellIdentifier];
    _mainTable.dataSource = self.arrayDataSource;
    [self.view addSubview:_mainTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.arrayDataSource appendWithItems:[CardsBox shareInstance].cardList];
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
