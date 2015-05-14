//
//  AdWebView.m
//  HSCards
//
//  Created by song jufeng on 15/5/14.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "AdWebView.h"
#import "CommonDefine.h"
@interface AdWebView()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView* webView;
@property(nonatomic, strong) NSURL*    actUrl;
@property(nonatomic, strong) UIActivityIndicatorView* indicatorView;
@end

@implementation AdWebView

-(void)setTargetURL:(NSURL *)url
{
    if (url != _actUrl) {
        _actUrl = url;
    }
}

-(void)loadTargetWebPage
{
    if (self.webView == nil)
    {
        [self firstLoadUrl];
    }
    if ([self.actUrl isKindOfClass:[NSURL class]]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.actUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0]];
        [self.indicatorView startAnimating];
    }
}


-(void)firstLoadUrl
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    for (UIView *subView in [self.webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    [self addSubview:self.webView];
    [self.webView.scrollView addSubview:self.indicatorView];
    
    [self.webView setDelegate:self];
//    self.webView.scrollView.delegate = self;
    self.webView.scalesPageToFit = YES;
//    [self.webView insertSubview:self.refreshView belowSubview:self.webView.scrollView];
}

-(void)reloadUrl
{
    [self.webView reload];
    [self.indicatorView startAnimating];
}

-(void)clearWebPage
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)wView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)wView
{
//    if (self.statusView && self.statusView.superview == wView.scrollView)
//    {
//        [self.statusView removeFromSuperview];
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)wView
{
    //[self.actView stopAnimating];
    [self.indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)wView didFailLoadWithError:(NSError *)error
{
    [self.indicatorView stopAnimating];
    DLog(@"error===========%@", error);
    [wView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
}

@end
