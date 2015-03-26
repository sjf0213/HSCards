//
//  MainLeftViewController.h
//  HSCards
//
//  Created by song jufeng on 15/3/16.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuNaviDelegate;

@interface MainLeftViewController : UIViewController
@property(nonatomic, weak)id<MenuNaviDelegate>delegate;
@end
