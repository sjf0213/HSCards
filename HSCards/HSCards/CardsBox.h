//
//  CardsBox.h
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardsBox : NSObject

@property(nonatomic, readonly)NSArray* cardList;
@property(nonatomic, readonly)NSMutableArray* filtedList;

+(CardsBox*)shareInstance;
-(void)addCardsByArray:(NSArray*)arr withCardSet:(NSString*)key;
-(void)fillFiltedList;
@end
