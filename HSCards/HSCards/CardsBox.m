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

-(void)addCardsByArray:(NSArray*)arr
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
            [resultArr addObject:cardItem];
        }
    }
    _cardList = [_cardList arrayByAddingObjectsFromArray:resultArr];
}

-(void)fillFiltedList
{
    [_filtedList removeAllObjects];
    
    // 1, 过滤费用
    NSMutableArray* costList = [NSMutableArray array];
    switch ([FilterData shareInstance].cost)
    {
        case mana_cost_all:
            [costList addObjectsFromArray:_cardList];
            break;
        case mana_cost_0:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 0) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_1:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 1) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_2:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 2) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_3:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 3) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_4:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 4) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_5:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 5) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_6:
            for (CardItemInfo* item in _cardList){
                if (item.cost == 6) {
                    [costList addObject:item];
                }
            }
            break;
        case mana_cost_7P:
            for (CardItemInfo* item in _cardList){
                if (item.cost > 6) {
                    [costList addObject:item];
                }
            }
            break;
    }
    //2,过滤稀有度
    NSMutableArray* rarityList = [NSMutableArray array];
    switch ([FilterData shareInstance].rarity) {
        case card_rarity_all:
            [rarityList addObjectsFromArray:costList];
            break;
        case card_rarity_free:
            for (CardItemInfo* item in costList) {
                if ([item.rarity isEqualToString:@"Free"]) {
                    [rarityList addObject:item];
                }
            }
            break;
        case card_rarity_common:
            for (CardItemInfo* item in costList) {
                if ([item.rarity isEqualToString:@"Common"]) {
                    [rarityList addObject:item];
                }
            }
            break;
        case card_rarity_rare:
            for (CardItemInfo* item in costList) {
                if ([item.rarity isEqualToString:@"Rare"]) {
                    [rarityList addObject:item];
                }
            }
            break;
        case card_rarity_epic:
            for (CardItemInfo* item in costList) {
                if ([item.rarity isEqualToString:@"Epic"]) {
                    [rarityList addObject:item];
                }
            }
            break;
        case card_rarity_legendary:
            for (CardItemInfo* item in costList) {
                if ([item.rarity isEqualToString:@"Legendary"]) {
                    [rarityList addObject:item];
                }
            }
            break;
    }
 
    
    //3，过滤职业
    NSMutableArray* careerList = [NSMutableArray array];
    switch ([FilterData shareInstance].career) {
                
        case card_career_all:
            [careerList addObjectsFromArray:rarityList];
            break;
        case card_career_druid:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Druid"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_hunter:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Hunter"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_mage:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Mage"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_paladin:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Paladin"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_priest:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Priest"]) {
                    [careerList addObject:item];
                }
            }
            break;
        
        case card_career_rogue:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Rogue"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_shaman:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Shaman"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_warlock:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Warlock"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_warrior:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Warrior"]) {
                    [careerList addObject:item];
                }
            }
            break;
        case card_career_dream:
            for (CardItemInfo* item in rarityList) {
                if ([item.career isEqualToString:@"Dream"]) {
                    [careerList addObject:item];
                }
            }
            break;
    }

    //4，过滤卡类型
    NSMutableArray* typeList = [NSMutableArray array];
    switch ([FilterData shareInstance].type) {
        case card_type_all:
            [typeList addObjectsFromArray:careerList];
            break;
        case card_type_minion:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Minion"]) {
                    [typeList addObject:item];
                }
            }
            break;
        case card_type_spell:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Spell"]) {
                    [typeList addObject:item];
                }
            }
            break;
        case card_type_weapon:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Weapon"]) {
                    [typeList addObject:item];
                }
            }
            break;
        case card_type_hero:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Hero"]) {
                    [typeList addObject:item];
                }
            }
            break;
        case card_type_heropower:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Hero Power"]) {
                    [typeList addObject:item];
                }
            }
            break;
        case card_type_enchantment:
            for (CardItemInfo* item in careerList) {
                if ([item.cardType isEqualToString:@"Enchantment"]) {
                    [typeList addObject:item];
                }
            }
            break;
        default:
            break;
        
    }
    [_filtedList addObjectsFromArray:typeList];
}

@end
