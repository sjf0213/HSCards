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
#import "RightSimpleSelectController.h"
#import "../ECSlidingViewController/ECSlidingViewController.h"
#import "FilterData.h"

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
    self.navigationItem.title = @"筛选";
    UIBarButtonItem *OKButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onTapOK)];
    self.navigationItem.rightBarButtonItem  = OKButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onTapCancel)];
    self.navigationItem.leftBarButtonItem  = cancelButton;
    
    TableViewCellConfigureBlock configureCell = ^(FilterListCell* cell, NSDictionary* data) {
        [cell clearData];
        [cell loadCellData:data];
    };
    self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:FilterTableCellIdentifier configureCellBlock:configureCell];
    _mainTable =  _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SlidingAnchorLeftRevealAmount, self.view.bounds.size.height)];
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
    [self updateDisplayData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    DLog(@"---------------Main Right viewWillAppear------------------");
    [self updateDisplayData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dicAll = [[FilterData shareInstance].displayTextArray objectAtIndex:indexPath.row];
    NSArray* condition = [dicAll objectForKey:@"condition"];
    
    RightSimpleSelectController* secondController = [[RightSimpleSelectController alloc] initWithDataArray:condition];
    [self.navigationController pushViewController:secondController animated:YES];
}

-(void)updateDisplayData
{
    NSMutableArray* levelOneArray = [NSMutableArray array];
    for (NSDictionary* item in [FilterData shareInstance].displayTextArray) {
        NSString* title = [item objectForKey:@"title"];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].cost];
        [levelOneArray addObject:@{@"title":title,
                                   @"result":resultText}];
    }
    [self.arrayDataSource removeAllItems];
    [self.arrayDataSource appendWithItems:levelOneArray];
    [_mainTable reloadData];
}

-(void)onTapOK
{
    if ([self.navigationController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navi = self.navigationController;
        if ([navi.parentViewController isKindOfClass:[ECSlidingViewController class]]) {
            ECSlidingViewController* ec = (ECSlidingViewController*)navi.parentViewController;
            [ec resetTopViewAnimated:YES];
            
//            if ([ec.topViewController isKindOfClass:NSClassFromString(@"MainTopViewController")]) {
//                [ec.topViewController performSelector:@selector(updateDisplayData)];
//            }
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_UpdateMainList object:nil];
        }
    }
}

-(void)onTapCancel
{
    if ([self.navigationController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navi = self.navigationController;
        if ([navi.parentViewController isKindOfClass:[ECSlidingViewController class]]) {
            ECSlidingViewController* ec = (ECSlidingViewController*)navi.parentViewController;
            [ec resetTopViewAnimated:YES];
        }
    }
}

- (void)dealloc
{
    DLog(@"----------------dealloc");
}

@end
