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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.42 green:0.70 blue:0.88 alpha:1];
    self.navigationItem.title = NSLocalizedString(@"Rules", @"");
    UIBarButtonItem *OKButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", @"") style:UIBarButtonItemStylePlain target:self action:@selector(onTapOK)];
    self.navigationItem.rightBarButtonItem  = OKButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CANCEL", @"")  style:UIBarButtonItemStylePlain target:self action:@selector(onTapCancel)];
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
    DLog(@"---------------Main Right view Will Appear------------------");
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_EnableTopScroll object:[NSNumber numberWithBool:NO]];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    DLog(@"---------------Main Right view Did Disappear------------------");
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_EnableTopScroll object:[NSNumber numberWithBool:YES]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dicAll = [[FilterData shareInstance].conditionEnumArray objectAtIndex:indexPath.row];
    NSArray* condition = [dicAll objectForKey:@"condition"];
    
    RightSimpleSelectController* secondController = [[RightSimpleSelectController alloc] initWithDataArray:condition];
    secondController.view.tag = indexPath.row;// 哪一个category
    [self.navigationController pushViewController:secondController animated:YES];
}

// 如果没有点击确定进行筛选，则恢复显示上次的删选条件
-(void)updateDisplayData
{
    NSMutableArray* levelOneArray = [NSMutableArray array];
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[0];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].cost];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[1];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].rarity];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[2];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].career];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[3];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].type];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[4];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].race];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    {
        NSDictionary* item  = [FilterData shareInstance].conditionEnumArray[5];
        NSArray* textArray = [item objectForKey:@"condition"];
        NSString* resultText = [textArray objectAtIndex:[FilterData shareInstance].cardSet];
        [levelOneArray addObject:@{@"title":[item objectForKey:@"title"],
                                   @"result":resultText}];
    }
    [self.arrayDataSource removeAllItems];
    [self.arrayDataSource appendWithItems:levelOneArray];
    [_mainTable reloadData];
}

// 选择之后暂时显示，点击确定之前不存储过滤条件
-(void)updateSingleCellAtIndex:(NSUInteger)index withText:(NSString*)str
{
    NSMutableArray* levelOneArray = [NSMutableArray array];
    for (int i = 0; i < self.arrayDataSource.items.count; i++)
    {
        NSDictionary* dic = [self.arrayDataSource.items objectAtIndex:i];
        if (index == i){
            [levelOneArray addObject:@{@"title":[dic objectForKey:@"title"],
                                       @"result":str}];
        }else{
            [levelOneArray addObject:dic];
        }
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
            
            // 存储过滤条件 cost
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:0];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:0];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].cost = i;
                        DLog(@"真正改变 FilterData 过滤条件值 cost = %d", i);
                        break;
                    }
                }
            }
            // rarity
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:1];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:1];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].rarity = i;
                        DLog(@"真正改变 FilterData 过滤条件值 rarity = %d", i);
                        break;
                    }
                }
            }
            
            // career
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:2];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:2];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].career = i;
                        DLog(@"真正改变 FilterData 过滤条件值 career = %d", i);
                        break;
                    }
                }
            }
            
            // type
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:3];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:3];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].type = i;
                        DLog(@"真正改变 FilterData 过滤条件值 type = %d", i);
                        break;
                    }
                }
            }
            // race
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:4];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:4];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].race = i;
                        DLog(@"真正改变 FilterData 过滤条件值 race = %d", i);
                        break;
                    }
                }
            }
            // set
            {
                NSDictionary* cellDataDic = [self.arrayDataSource.items objectAtIndex:5];
                NSString* cellResultStr = [cellDataDic objectForKey:@"result"];
                NSDictionary* filterDataDic = [[FilterData shareInstance].conditionEnumArray objectAtIndex:5];
                NSArray* arrCondition = [filterDataDic objectForKey:@"condition"];
                for (int i = 0; i < arrCondition.count; i++)
                {
                    if ([cellResultStr isEqualToString:NSLocalizedString([arrCondition objectAtIndex:i],@"")]) {
                        [FilterData shareInstance].cardSet = i;
                        DLog(@"真正改变 FilterData 过滤条件值 set = %d", i);
                        break;
                    }
                }
            }
            // 刷新列表
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
            [ec resetTopViewAnimated:YES onComplete:^{
                // 恢复之前已经确定的过滤选项
                [self updateDisplayData];
            }];
        }
    }
}

- (void)dealloc
{
    DLog(@"----------------dealloc");
}

@end
