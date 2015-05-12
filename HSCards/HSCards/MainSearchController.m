//
//  MainSearchController.m
//  HSCards
//
//  Created by song jufeng on 15/4/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainSearchController.h"
#import "CommonDefine.h"

@interface MainSearchController ()<UISearchBarDelegate>
@property(nonatomic, strong)UISearchBar* searchBar;
@end

@implementation MainSearchController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    [self.view addSubview:_searchBar];
//    [_searchBar becomeFirstResponder];
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews
{
    DLog(@"----------view Will Layout Subviews -+-+-+-+-");
    //self.mainTable.frame = self.view.bounds;
//    [self.parentController.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
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

@end
