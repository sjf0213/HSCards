//
//  AdViewController.m
//  HSCards
//
//  Created by song jufeng on 15/5/14.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "AdViewController.h"
#import "AdWebView.h"

@interface AdViewController ()<UIWebViewDelegate>
@property (nonatomic) AdWebView  *webView;

@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[AdWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_webView];
    
    UIButton* backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    backBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 3.0f;
    backBtn.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    backBtn.layer.borderWidth = 0.5f;
    [backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAdURL:(NSURL*)url
{
//    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView setTargetURL:url];
    [self.webView loadTargetWebPage];
}

-(void)onBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
