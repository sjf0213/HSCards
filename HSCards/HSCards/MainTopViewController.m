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
#import "MainSearchController.h"

#define CardListCellIdentifier @"CardListCell"

@interface MainTopViewController ()<UITableViewDelegate, UISearchBarDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@property(nonatomic, strong)UIView* mask;
@end

@implementation MainTopViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    _mainTable.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.view addSubview:_mainTable];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -44, _mainTable.frame.size.width, 44)];
    _searchBar.delegate = self;
//    _searchBar.showsCancelButton = YES;
    [_mainTable addSubview:_searchBar];
    
    
    _mask = [[UIView alloc] initWithFrame:self.view.bounds];
    _mask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _mask.hidden = YES;
    [self.view addSubview:_mask];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayData) name:Notification_UpdateMainList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableTopScroll:) name:Notification_EnableTopScroll object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateDisplayData];
    // 下载所有卡牌图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[CardsBox shareInstance] downloadAllCollectibleCards];
    });
    
}

-(void)viewWillLayoutSubviews
{
    DLog(@"----------view Will Layout Subviews -+-+-+-+-");
    self.mainTable.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enableTopScroll:(NSNotification*)flag
{
    NSNumber* v = flag.object;
    BOOL enable = [v boolValue];
    //DLog(@"----------enableTopScroll:%d", enable);
    self.view.userInteractionEnabled = enable;
    if (enable) {
        //_mask.alpha = 1.0;
        [UIView animateWithDuration:0.2 animations:^{
            _mask.alpha = 0.0;
        } completion:^(BOOL finished){
            _mask.hidden = YES;
        }];
    }else{
//        _mask.alpha = 0.0;
        _mask.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            _mask.alpha = 1.0;
        }];
    }
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
//    _mainTable.contentOffset = CGPointMake(0.0, -_mainTable.contentInset.top);
    [_mainTable reloadData];
    self.navigationItem.title = [NSString stringWithFormat:@"共有 %zd 张卡牌", self.arrayDataSource.items.count];
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
//    DLog(@"--------------------*---didSelectRowAtIndexPath = %d", indexPath.row);
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

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    DLog(@"----------search Bar Text Did Begin Editing ------01");
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
//        [wself.searchBar becomeFirstResponder];
        [wself.navigationController setNavigationBarHidden:YES animated:YES];

    } completion:^(BOOL finished) {
        MainSearchController* controller = [[MainSearchController alloc] init];
        controller.parentController = self;
        [wself presentViewController:controller animated:NO completion:nil];
    }];
    
//    [self.view setNeedsDisplay];
}
@end
