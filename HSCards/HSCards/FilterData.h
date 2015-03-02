//
//  FilterData.h
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    mana_cost_all = 0,
    mana_cost_0 = 1,
    mana_cost_1 = 2,
    mana_cost_2 = 3,
    mana_cost_3 = 4,
    mana_cost_4 = 5,
    mana_cost_5 = 6,
    mana_cost_6 = 7,
    mana_cost_7P = 8,
} mana_cost;

typedef enum : NSUInteger {
    card_rarity_all = 0,
    card_rarity_0 = 1,
    card_rarity_1 = 2,
    card_rarity_2 = 3,
    card_rarity_3 = 4,
    card_rarity_4 = 5,
    card_rarity_5 = 6,
} card_rarity;

@interface FilterData : NSObject
@property(atomic, readonly)NSArray* displayTextArray;
@property(atomic, assign)mana_cost cost;
@property(atomic, assign)card_rarity rarity;
+(FilterData*)shareInstance;

@end
