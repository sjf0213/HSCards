//
//  CardListView.h
//  HSCards
//
//  Created by song jufeng on 15/5/12.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CardListCellIdentifier @"CardListCell"

@class ArrayDataSource;
@class CardItemInfo;

@protocol CardListViewDelegate
@optional
    -(void)onShowCardDetail:(CardItemInfo*)cardInfo;
@end

@interface CardListView : UIView

@property(nonatomic, weak)UIViewController<CardListViewDelegate>* delegate;
@property(atomic, readonly) ArrayDataSource *arrayDataSource;

-(void)reloadDisplayData;

@end
