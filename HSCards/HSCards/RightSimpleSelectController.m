//
//  RightSimpleSelectController.m
//  HSCards
//
//  Created by song jufeng on 15/2/27.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "RightSimpleSelectController.h"
#import "CommonDefine.h"
#import "FilterData.h"
#import "MainRightViewController.h"
#import "ArrayDataSource.h"
#define SimpleSelectCellIdentifier @"SimpleSelectCell"

@interface RightSimpleSelectController ()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
@end

@implementation RightSimpleSelectController

-(id)initWithDataArray:(NSArray*)arr
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        TableViewCellConfigureBlock configureCell = ^(UITableViewCell* cell, NSString* data) {
            cell.backgroundColor= [UIColor clearColor];
            cell.textLabel.text = @"";
            cell.textLabel.textColor = [UIColor colorWithRed:76/255.0 green:80/255.0 blue:98/255.0 alpha:1.0];
            if ([data isKindOfClass:[NSString class]]) {
                cell.textLabel.text = NSLocalizedString(data,@"");
            }
        };
        self.arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:SimpleSelectCellIdentifier configureCellBlock:configureCell];
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds];
        _mainTable.backgroundColor = ColorLevel2;
        _mainTable.rowHeight = 44;
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:SimpleSelectCellIdentifier];
        _mainTable.dataSource = self.arrayDataSource;
        _mainTable.delegate = self;
        [self.view addSubview:_mainTable];
        
        [self.arrayDataSource appendWithItems:arr];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    [_mainTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController* controller = [self.navigationController.viewControllers objectAtIndex:0];
    if ([controller isKindOfClass: [MainRightViewController class]]) {
        MainRightViewController* rc = (MainRightViewController*)controller;
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        [rc updateSingleCellAtIndex:self.view.tag withText:cell.textLabel.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
