//
//  AdWebView.h
//  HSCards
//
//  Created by song jufeng on 15/5/14.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdWebView : UIView
-(void)setTargetURL:(NSURL *)url;
-(void)loadTargetWebPage;
-(void)reloadUrl;
-(void)clearWebPage;
@end
