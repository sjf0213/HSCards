//
//  CardDetailViewController.h
//  HSCards
//
//  Created by song jufeng on 15/3/5.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardItemInfo;
@interface CardDetailViewController : UIViewController

-(void)loadCardInfo:(CardItemInfo*)info;

@end
