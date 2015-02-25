//
//  MainTopViewController.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainTopViewController.h"

@interface MainTopViewController ()
@property(nonatomic, strong)UITableView* mainTable;
@end

@implementation MainTopViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.8 alpha:1.0];
    _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    _mainTable.rowHeight = MainList_Row_H;
    [self.view addSubview:_mainTable];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
