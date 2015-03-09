//
//  MainTopViewController.h
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ECSlidingViewController;

@interface MainTopViewController : UIViewController

@property(nonatomic, weak)ECSlidingViewController* parentSliding;

-(void)updateDisplayData;

@end
