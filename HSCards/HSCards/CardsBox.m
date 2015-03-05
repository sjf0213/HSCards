//
//  CardsBox.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardsBox.h"
#import "CardItemInfo.h"
#import "FilterData.h"
#import "CommonDefine.h"
@interface CardsBox()

@end

static CardsBox * m_Instance;

@implementation CardsBox

+(CardsBox*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_Instance= [[CardsBox alloc] initSingleton];
    });
    return m_Instance;
}

-(id)init
{
    NSAssert(NO, @"Cannot create instance of Singleton");
    return nil;
}

-(id)initSingleton
{
    self = [super init];
    if(self)
    {
        _cardList = [[NSArray alloc] init];
        _filtedList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addCardsByArray:(NSArray*)arr withCardSet:(NSString*)key
{
    if (NO == [arr isKindOfClass:[NSArray class]]) {
        return;
    }
    NSMutableArray* resultArr = [NSMutableArray new];
    for (int i = 0; i < arr.count; i++)
    {
        NSDictionary* itemDic = [arr objectAtIndex:i];
        if ([itemDic isKindOfClass:[NSDictionary class]]) {
            CardItemInfo* cardItem = [[CardItemInfo alloc] initWithDic:itemDic];
            if ([key isKindOfClass:[NSString class]]) {
                [cardItem setCardSet:key];
            }
            [resultArr addObject:cardItem];
        }
    }
    _cardList = [_cardList arrayByAddingObjectsFromArray:resultArr];
}

-(void)fillFiltedList
{
    [_filtedList removeAllObjects];
    NSMutableArray* resultList = [NSMutableArray array];
    NSArray* sourceArray = [NSArray new];
    
    sourceArray = _cardList;
    
    // 0, 过滤所有可收集的卡
    for (CardItemInfo* item in sourceArray) {
        if (YES == item.collectible) {
            [resultList addObject:item];
        }
    }
    DLog(@"All the COLLECTIBLE cards count = %zd", resultList.count);
    // 1, 过滤费用
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].cost)
    {
        case mana_cost_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case mana_cost_0:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 0) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_1:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 1) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_2:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 2) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_3:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 3) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_4:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 4) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_5:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 5) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_6:
            for (CardItemInfo* item in sourceArray){
                if (item.cost == 6) {
                    [resultList addObject:item];
                }
            }
            break;
        case mana_cost_7P:
            for (CardItemInfo* item in sourceArray){
                if (item.cost > 6) {
                    [resultList addObject:item];
                }
            }
            break;
    }
    
    //2,过滤稀有度
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].rarity) {
        case card_rarity_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case card_rarity_free:
            for (CardItemInfo* item in sourceArray) {
                if ([item.rarity isEqualToString:@"Free"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_rarity_common:
            for (CardItemInfo* item in sourceArray) {
                if ([item.rarity isEqualToString:@"Common"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_rarity_rare:
            for (CardItemInfo* item in sourceArray) {
                if ([item.rarity isEqualToString:@"Rare"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_rarity_epic:
            for (CardItemInfo* item in sourceArray) {
                if ([item.rarity isEqualToString:@"Epic"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_rarity_legendary:
            for (CardItemInfo* item in sourceArray) {
                if ([item.rarity isEqualToString:@"Legendary"]) {
                    [resultList addObject:item];
                }
            }
            break;
    }
 
    
    //3，过滤职业
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].career) {
        case card_career_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case card_career_neutral:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Neutral"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_druid:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Druid"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_hunter:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Hunter"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_mage:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Mage"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_paladin:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Paladin"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_priest:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Priest"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_rogue:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Rogue"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_shaman:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Shaman"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_warlock:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Warlock"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_warrior:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Warrior"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_career_dream:
            for (CardItemInfo* item in sourceArray) {
                if ([item.career isEqualToString:@"Dream"]) {
                    [resultList addObject:item];
                }
            }
            break;
    }

    //4，过滤卡类型
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].type) {
        case card_type_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case card_type_minion:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Minion"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_type_spell:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Spell"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_type_weapon:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Weapon"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_type_hero:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Hero"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_type_heropower:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Hero Power"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_type_enchantment:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardType isEqualToString:@"Enchantment"]) {
                    [resultList addObject:item];
                }
            }
            break;
        
    }
    
    //5，过滤种族
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].race) {
        case card_race_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case card_race_beast:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Beast"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_demon:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Demon"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_dragon:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Dragon"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_mech:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Mech"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_murloc:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Murloc"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_pirate:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Pirate"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_race_totem:
            for (CardItemInfo* item in sourceArray) {
                if ([item.race isEqualToString:@"Totem"]) {
                    [resultList addObject:item];
                }
            }
            break;
    }
    
    //6，过滤集合
    sourceArray = resultList;
    resultList = [NSMutableArray new];
    switch ([FilterData shareInstance].cardSet) {
        case card_set_all:
            [resultList addObjectsFromArray:sourceArray];
            break;
        case card_set_system:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"System"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_basic:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Basic"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_classic:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Classic"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_missions:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Missions"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_promotion:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Promotion"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_reward:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Reward"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_credits:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Credits"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_debug:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Debug"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_naxx:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Curse of Naxxramas"]) {
                    [resultList addObject:item];
                }
            }
            break;
        case card_set_gvg:
            for (CardItemInfo* item in sourceArray) {
                if ([item.cardSet isEqualToString:@"Goblins vs Gnomes"]) {
                    [resultList addObject:item];
                }
            }
            break;
    }
    [_filtedList addObjectsFromArray:resultList];
}

@end
