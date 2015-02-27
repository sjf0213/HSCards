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

#define FilterTableCellIdentifier @"FilterTableCell"

@interface MainRightViewController ()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@property(nonatomic, strong)NSArray* filterDataArr;
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
    DLog(@"------------width = %f", self.view.frame.size.width);
    // Do any additional setup after loading the view.
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"];
    _filterDataArr = [NSArray arrayWithContentsOfFile:dataPath];
    DLog(@"_filterDataArr = %@", _filterDataArr);
    NSMutableArray* levelOneArray = [NSMutableArray array];
    for (NSDictionary* item in _filterDataArr) {
        NSString* title = [item objectForKey:@"title"];
        [levelOneArray addObject:title];
    }
    [self.arrayDataSource appendWithItems:levelOneArray];
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"---------------didSelectRowAtIndexPath------------------");
    NSDictionary* dicAll = [_filterDataArr objectAtIndex:indexPath.row];
    NSArray* condition = [dicAll objectForKey:@"condition"];
    
    RightSimpleSelectController* secondController = [[RightSimpleSelectController alloc] initWithDataArray:condition];
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

-(void)onTapOK
{
    DLog(@"-*-*-*-onTapOK*-*-*-*");
    [self resetTopController];
}
-(void)onTapCancel
{
    DLog(@"-*-*-*-onTapCancel*-*-*-*");
    [self resetTopController];
}

-(void)resetTopController
{
    if ([self.navigationController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navi = self.navigationController;
        if ([navi.parentViewController isKindOfClass:[ECSlidingViewController class]]) {
            ECSlidingViewController* ec = (ECSlidingViewController*)navi.parentViewController;
            [ec resetTopViewAnimated:YES];
        }
    }
}


@end
