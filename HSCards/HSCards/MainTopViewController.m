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
#import "CommonDefine.h"
#import "CardDetailView.h"
#import "CardDetailViewController.h"
#import "../ECSlidingViewController/ECSlidingViewController.h"

#define CardListCellIdentifier @"CardListCell"

@interface MainTopViewController ()<UITableViewDelegate>
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
    _mainTable.delegate = self;
    [self.view addSubview:_mainTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayData) name:Notification_UpdateMainList object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateDisplayData];
    // 下载所有卡牌图片
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[CardsBox shareInstance] downloadAllCollectibleCards];
//    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateDisplayData
{
    [[CardsBox shareInstance] fillFiltedList];
    [self.arrayDataSource removeAllItems];
    [self.arrayDataSource appendWithItems:[CardsBox shareInstance].filtedList];
    // 打印前N个卡牌
    /*{
        int n = [CardsBox shareInstance].filtedList.count;
        n = n > 50 ? 50 : n;
        for (int i = 0; i < n; i++)
        {
            CardItemInfo* obj = [CardsBox shareInstance].filtedList[i];
            DLog(@"obj = %@", obj);
        }
    }*/
    // 打印某种属性的所有枚举
    /*{
        NSMutableArray* arr = [NSMutableArray array];
        for (CardItemInfo* item in [CardsBox shareInstance].filtedList)
        {
            NSString* str = item.race;
            if ([str isKindOfClass:[NSString class]])
            {
                if (0 == arr.count) {
                    [arr addObject:str];
                }else{
                    if ([str isKindOfClass:[NSString class]]){
                        for (int i = 0; i < arr.count; i++){
                            NSString* alreadyHave = arr[i];
                            if ([str isEqualToString:alreadyHave]){
                                break;
                            }
                            if (i == arr.count - 1){
                                [arr addObject:str];
                            }
                        }
                    }
                }
            }
        }
        DLog(@"--------------------*---race.arr = %@", arr);
    }*/
    [_mainTable reloadData];
    
    self.navigationItem.title = [NSString stringWithFormat:@"共有%zd张卡牌", self.arrayDataSource.items.count];
}

-(void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    //self.parentSliding.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureNone;
    self.parentSliding.panGesture.enabled = NO;// 禁用左右两侧的Controller
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"--------------------*---didSelectRowAtIndexPath = %d", indexPath.row);
//    CardDetailView* detailView = [[CardDetailView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:detailView];
    CardItemInfo* info = [self.arrayDataSource itemAtIndexPath:indexPath];
    CardDetailViewController*  controller = [[CardDetailViewController alloc] init];
    typeof(self)__weak wself = self;
    controller.didDismissHandler = ^{wself.parentSliding.panGesture.enabled = YES;};
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    self.navigationController.navigationBar.hidden = YES;
    [controller loadCardInfo:info];
}
@end
