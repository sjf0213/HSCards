//
//  MainLeftViewController.m
//  HSCards
//
//  Created by song jufeng on 15/3/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "MainLeftViewController.h"
#import "CommonDefine.h"
#import "ArrayDataSource.h"
#import "LeftMenuCell.h"
#import "MobClick.h"
#import "MenuNaviDelegate.h"

#define LeftMenuCellIdentifier @"LeftMenuCell"

@interface MainLeftViewController ()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
//@property(nonatomic, strong)UIWebView* adWebView;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@property(nonatomic, strong)NSString* adURLString;
@end

@implementation MainLeftViewController
- (void)loadView
{
    [super loadView];
    
    UIView* bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    bar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    TableViewCellConfigureBlock configureCell = ^(LeftMenuCell* cell, NSDictionary* data) {
        [cell clearData];
        [cell loadCellData:data];
    };
    self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:LeftMenuCellIdentifier configureCellBlock:configureCell];
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SlidingAnchorRightRevealAmount, self.view.bounds.size.height - 64)];
    self.mainTable.rowHeight = LeftMenu_Row_H;
    [self.mainTable registerClass:[LeftMenuCell class] forCellReuseIdentifier:LeftMenuCellIdentifier];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self.arrayDataSource;
    [self.view addSubview:self.mainTable];
    
    [self.arrayDataSource appendWithItems:@[@{@"tag":@"home",@"title":@"Home",@"icon":@"menu_home"},
                                            @{@"tag":@"search",@"title":@"Search",@"icon":@"menu_search"},
                                            @{@"tag":@"ad",@"title":@"AD",@"icon":@"menu_ad"}]];
    [self.mainTable reloadData];
    
//    self.adWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:1 alpha:1.0];
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        wself.adURLString = [MobClick getAdURL];
//        DLog(@"-------------*---------------getAdURL: %@", self.adURLString);
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuCell* cell  = (LeftMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    if ([cell.tagStr isEqualToString:@"home"])
    {
        DLog(@"-------------*-------------Home");
        [self.delegate navigateToPage:@"home"];
    }
    if ([cell.tagStr isEqualToString:@"search"])
    {
        DLog(@"-------------*-------------SEARCH");
        [self.delegate navigateToPage:@"search"];
    }
    if ([cell.tagStr isEqualToString:@"ad"] && [self.adURLString isKindOfClass:[NSString class]])
    {
        DLog(@"-------------*-------------SHOW AD");
        [self.delegate navigateToPage:@"ad"];
    }
}

@end
