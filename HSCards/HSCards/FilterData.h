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
    mana_cost_0,
    mana_cost_1,
    mana_cost_2,
    mana_cost_3,
    mana_cost_4,
    mana_cost_5,
    mana_cost_6,
    mana_cost_7P,
} mana_cost;

typedef enum : NSUInteger {
    card_rarity_all = 0,
    card_rarity_0,
    card_rarity_1,
    card_rarity_2,
    card_rarity_3,
    card_rarity_4,
    card_rarity_5,
} card_rarity;

typedef enum : NSUInteger {
    card_career_all = 0,
    card_career_0,
    card_career_2,
    card_career_3,
    card_career_4,
    card_career_5,
    card_career_6,
    card_career_7,
    card_career_8,
    card_career_9,
    card_career_10,
    card_career_11,
} card_career;

typedef enum : NSUInteger {
    card_type_all = 0,
    card_type_1,
    card_type_2,
    card_type_3,
    card_type_4bonus,
    card_type_5,
    
} card_type;

@interface FilterData : NSObject
@property(atomic, readonly)NSArray* displayTextArray;
@property(atomic, assign)mana_cost cost;
@property(atomic, assign)card_rarity rarity;
@property(atomic, assign)card_career career;
@property(atomic, assign)card_type type;
+(FilterData*)shareInstance;

@end
