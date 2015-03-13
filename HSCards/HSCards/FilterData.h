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
    card_career_neutral,//中立
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
    card_type_enchantment,//效果
    
} card_type;

typedef enum : NSUInteger {
    card_race_all = 0,
    card_race_murloc,//鱼人
    card_race_demon,//恶魔
    card_race_beast,//野兽
    card_race_totem,//图腾
    card_race_pirate,//海盗
    card_race_dragon,//龙
    card_race_mech,//机械
    
} card_race;

typedef enum : NSUInteger {
    card_set_all = 0,
    card_set_naxx,//纳克萨玛斯
    card_set_gvg,//地精大战侏儒
    card_set_system,//系统占位
    card_set_basic,//基本
    card_set_classic,//经典
    card_set_missions,//任务
    card_set_promotion,//促销
    card_set_reward,//奖励
    card_set_credits,//信用
    card_set_debug,//调整过
} card_set;

@interface FilterData : NSObject
@property(atomic, readonly)NSArray* displayTextArray;
@property(atomic, assign)mana_cost cost;
@property(atomic, assign)card_rarity rarity;
@property(atomic, assign)card_career career;
@property(atomic, assign)card_type type;
@property(atomic, assign)card_race race;
@property(atomic, assign)card_set cardSet;
+(FilterData*)shareInstance;

@end
