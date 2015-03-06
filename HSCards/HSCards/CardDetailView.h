//
//  CardDetailView.h
//  HSCards
//
//  Created by song jufeng on 15/3/6.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardItemInfo;

typedef void(^DidDismissHandler)(void);

@interface CardDetailView : UIView

@property (nonatomic, copy)  void(^didDismissHandler)(void);

-(void)loadCardInfo:(CardItemInfo*)info;

@end
