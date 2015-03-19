//
//  CardDetailViewController.m
//  HSCards
//
//  Created by song jufeng on 15/3/5.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardDetailViewController.h"
#import "CardDetailView.h"
#import "CardItemInfo.h"

@interface CardDetailViewController ()
@property(nonatomic, strong) CardDetailView* mainView;
@end

@implementation CardDetailViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.75];
    _mainView = [[CardDetailView alloc] initWithFrame:self.view.bounds];
    typeof(self) __weak wself = self;
    _mainView.didDismissHandler = ^{
        [wself.view removeFromSuperview];
        wself.navigationController.navigationBar.hidden = NO;
        [wself removeFromParentViewController];
        if (wself.didDismissHandler) {
            wself.didDismissHandler();
        }
    };
    [self.view addSubview:_mainView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadCardInfo:(CardItemInfo*)info
{
    [_mainView loadCardInfo:info];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
