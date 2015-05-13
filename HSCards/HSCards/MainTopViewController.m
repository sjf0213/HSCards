//
//  MainTopViewController.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainTopViewController.h"
#import "ArrayDataSource.h"
#import "CardListView.h"
#import "CardListCell.h"
#import "CardItemInfo.h"
#import "CardsBox.h"
#import "CommonDefine.h"
#import "CardDetailView.h"
#import "CardDetailViewController.h"
#import "../ECSlidingViewController/ECSlidingViewController.h"
#import "MainSearchController.h"

@interface MainTopViewController ()<UITableViewDelegate, UISearchBarDelegate, CardListViewDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@property(nonatomic, strong)CardListView* mainView;
@property(nonatomic, strong)UIView* mask;
@property(nonatomic, strong)MainSearchController* searchController;
@end

@implementation MainTopViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mainView = [[CardListView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, _mainView.frame.size.width, 44)];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
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
    //self.mainTable.frame = self.view.bounds;
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
    [self.mainView.arrayDataSource removeAllItems];
    [self.mainView.arrayDataSource appendWithItems:[CardsBox shareInstance].filtedList];
    [self.mainView reloadDisplayData];
    self.navigationItem.title = [NSString stringWithFormat:@"共有 %zd 张卡牌", self.mainView.arrayDataSource.items.count];
}

-(void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    //self.parentSliding.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureNone;
    self.parentSliding.panGesture.enabled = NO;// 禁用左右两侧的Controller
}

#pragma mark - CardListViewDelegate

-(void)onShowCardDetail:(CardItemInfo*)cardInfo
{
    CardDetailViewController*  controller = [[CardDetailViewController alloc] init];
    typeof(self)__weak wself = self;
    controller.didDismissHandler = ^{wself.parentSliding.panGesture.enabled = YES;};
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    self.navigationController.navigationBar.hidden = YES;
    [controller loadCardInfo:cardInfo];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self pushSearchController];
}

#pragma mark - searchController

-(void)pushSearchController
{
    DLog(@"----------push SearchController ------01");
    __weak typeof(self) wself = self;
//    [wself.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
        
        
    } completion:^(BOOL finished) {
    
        wself.searchController = [[MainSearchController alloc] init];
        wself.searchController.parentController = self;
        [wself presentViewController:wself.searchController animated:NO completion:nil];
    }];
}

-(void)popSearchController
{
    DLog(@"----------pop SearchController ------02");
    __weak typeof(self) wself = self;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself setNeedsStatusBarAppearanceUpdate];
        });
    }];
}
@end
