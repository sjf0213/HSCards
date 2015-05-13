//
//  MainSearchController.m
//  HSCards
//
//  Created by song jufeng on 15/4/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainSearchController.h"
#import "CommonDefine.h"
#import "CardListView.h"
#import "CardsBox.h"
#import "CardItemInfo.h"
#import "ArrayDataSource.h"
#import "CardDetailViewController.h"

@interface MainSearchController ()<UISearchBarDelegate, CardListViewDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@property(nonatomic, strong)CardListView* mainView;
@property(nonatomic, strong)UILabel* labelTitle;
@end

@implementation MainSearchController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"back_btn_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainView = [[CardListView alloc] initWithFrame:CGRectMake(0, 44+64, self.view.frame.size.width, self.view.bounds.size.height -44-64)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44+20, self.view.frame.size.width, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = NO;
    [self.view addSubview:_searchBar];
    
    
    
//    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, 20, 100, 44)];
//    [cancelBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancelBtn];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(64, 20, self.view.bounds.size.width - 128, 44)];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.text = @"搜索卡牌";
    [self.view addSubview:_labelTitle];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
//    [self.mainView updateDisplayData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onBack
{
    [_searchBar resignFirstResponder];
    if ([self.parentController respondsToSelector:@selector(popSearchController)]) {
        [self.parentController performSelector:@selector(popSearchController) withObject:nil];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    [self onBack];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    DLog(@"--------------SearchButtonClicked:%@", searchBar.text);
    [_searchBar resignFirstResponder];
    NSMutableArray* resultArr = [[NSMutableArray alloc] init];
    for (CardItemInfo* item in [CardsBox shareInstance].collectibleCardList) {
        if([item canMatchSearchText:searchBar.text])
        {
            [resultArr addObject:item];
        }
    }
    [self.mainView.arrayDataSource removeAllItems];
    [self.mainView.arrayDataSource appendWithItems:resultArr];
    [self.mainView reloadDisplayData];
    if (resultArr.count == 0) {
        _labelTitle.text = @"没有找到卡牌";
    }else{
        _labelTitle.text = [NSString stringWithFormat:@"共找到 %zd 张卡牌", resultArr.count];
    }
}

#pragma mark - CardListViewDelegate

-(void)onShowCardDetail:(CardItemInfo*)cardInfo
{
    CardDetailViewController*  controller = [[CardDetailViewController alloc] init];
//    typeof(self)__weak wself = self;
//    controller.didDismissHandler = ^{wself.parentSliding.panGesture.enabled = YES;};
//    [self presentViewController:controller animated:YES completion:nil];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller loadCardInfo:cardInfo];
}

@end
