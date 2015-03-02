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
    NSMutableArray* costList = [NSMutableArray array];
    // 过滤费用
    
    for (CardItemInfo* item in _cardList) {
        switch ([FilterData shareInstance].cost) {
            case mana_cost_all:
                [costList addObjectsFromArray:_cardList];
                break;
            case mana_cost_0:
                if (item.cost == 0) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_1:
                if (item.cost == 1) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_2:
                if (item.cost == 2) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_3:
                if (item.cost == 3) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_4:
                if (item.cost == 4) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_5:
                if (item.cost == 5) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_6:
                if (item.cost == 6) {
                    [costList addObject:item];
                }
                break;
            case mana_cost_7P:
                if (item.cost > 6) {
                    [costList addObject:item];
                }
                break;
                
            default:
                break;
        }
    }
    //过滤
    NSMutableArray* rarityList = [NSMutableArray array];
    for (CardItemInfo* item in costList) {
        switch ([FilterData shareInstance].rarity) {
            case card_rarity_all:
                [rarityList addObjectsFromArray:costList];
                break;
            case card_rarity_0:
                if (item.rarity == 0) {
                    [rarityList addObject:item];
                }
                break;
            case card_rarity_1:
                if (item.rarity == 1) {
                    [rarityList addObject:item];
                }
                break;
            case card_rarity_2:
                if (item.rarity == 2) {
                    [rarityList addObject:item];
                }
                break;
            case card_rarity_3:
                if (item.rarity == 3) {
                    [rarityList addObject:item];
                }
                break;
            case card_rarity_4:
                if (item.rarity == 4) {
                    [rarityList addObject:item];
                }
                break;
            case card_rarity_5:
                if (item.rarity == 5) {
                    [rarityList addObject:item];
                }
                break;
            default:
                break;
        }
    }
    
    [_filtedList addObjectsFromArray:rarityList];
}

@end
