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
    card_rarity_free,//免费
    card_rarity_common,//白色普通
    card_rarity_rare,//蓝色稀有
    card_rarity_epic,//紫色史诗
    card_rarity_legendary,//橙色传奇
} card_rarity;

typedef enum : NSUInteger {
    card_career_all = 0,
    card_career_druid,//德鲁伊
    card_career_hunter,//猎人
    card_career_mage,//法师
    card_career_paladin,//圣骑士
    card_career_priest,//牧师
    card_career_rogue,//潜行者
    card_career_shaman,//萨满
    card_career_warlock,//术士
    card_career_warrior,// 战士
    card_career_dream,// 梦境
} card_career;

typedef enum : NSUInteger {
    card_type_all = 0,
    card_type_minion,//随从
    card_type_spell,//法术
    card_type_weapon,//武器
    card_type_hero,//英雄
    card_type_heropower,//英雄技能
    card_type_enchantment,//不清楚
    
} card_type;

@interface FilterData : NSObject
@property(atomic, readonly)NSArray* displayTextArray;
@property(atomic, assign)mana_cost cost;
@property(atomic, assign)card_rarity rarity;
@property(atomic, assign)card_career career;
@property(atomic, assign)card_type type;
+(FilterData*)shareInstance;

@end
