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

@interface MainSearchController ()<UISearchBarDelegate, CardListViewDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@property(nonatomic, strong)CardListView* mainView;
@end

@implementation MainSearchController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _mainView = [[CardListView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.bounds.size.height - 64)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    [self.view addSubview:_searchBar];
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    typeof(self)__weak wself = self;
    [_searchBar resignFirstResponder];
    if ([wself.parentController respondsToSelector:@selector(popSearchController)]) {
        [wself.parentController performSelector:@selector(popSearchController) withObject:nil];
    }
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
}

@end
