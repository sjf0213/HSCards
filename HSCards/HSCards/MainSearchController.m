//
//  MainSearchController.m
//  HSCards
//
//  Created by song jufeng on 15/4/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainSearchController.h"

@interface MainSearchController ()<UISearchBarDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@end

@implementation MainSearchController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    [self.view addSubview:_searchBar];
    [_searchBar becomeFirstResponder];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
