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
    if ([FilterData shareInstance].cost == mana_cost_all)
    {
        [costList addObjectsFromArray:_cardList];
    }
    else
    {
        switch ([FilterData shareInstance].cost) {
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
            default:
                break;
        }
    }
    //2,过滤稀有度
    NSMutableArray* rarityList = [NSMutableArray array];
    if ([FilterData shareInstance].rarity == card_rarity_all)
    {
        [rarityList addObjectsFromArray:costList];
    }
    else
    {
        switch ([FilterData shareInstance].rarity) {
            case card_rarity_0:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 0) {
                        [rarityList addObject:item];
                    }
                }
                break;
            case card_rarity_1:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 1) {
                        [rarityList addObject:item];
                    }
                }
                break;
            case card_rarity_2:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 2) {
                        [rarityList addObject:item];
                    }
                }
                break;
            case card_rarity_3:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 3) {
                        [rarityList addObject:item];
                    }
                }
                break;
            case card_rarity_4:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 4) {
                        [rarityList addObject:item];
                    }
                }
                break;
            case card_rarity_5:
                for (CardItemInfo* item in costList) {
                    if (item.rarity == 5) {
                        [rarityList addObject:item];
                    }
                }
                break;
            default:
                break;
        }
    }
    
    //3，过滤职业
    NSMutableArray* careerList = [NSMutableArray array];
    if ([FilterData shareInstance].career == card_career_all)
    {
        [careerList addObjectsFromArray:rarityList];
    }
    else
    {
        switch ([FilterData shareInstance].career) {
            case card_career_0:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 0) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_1:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 1) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_2:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 2) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_3:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 3) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_4:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 4) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_5:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 5) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_6:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 6) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_7:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 7) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_8:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 8) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_9:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 9) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_10:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 10) {
                        [careerList addObject:item];
                    }
                }
                break;
            case card_career_11:
                for (CardItemInfo* item in rarityList) {
                    if (item.career == 11) {
                        [careerList addObject:item];
                    }
                }
                break;
            default:
                break;
        }
    }
    
    //4，过滤卡类型
    NSMutableArray* typeList = [NSMutableArray array];
    if ([FilterData shareInstance].type == card_type_all)
    {
        [typeList addObjectsFromArray:careerList];
    }
    else
    {
        
        switch ([FilterData shareInstance].type) {
            case card_type_0:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 0) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_1:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 1) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_2:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 2) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_3:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 3) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_4:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 4) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_5:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 5) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_6:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 6) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_7:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 7) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_8:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 8) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_9:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 9) {
                        [typeList addObject:item];
                    }
                }
                break;
            case card_type_10:
                for (CardItemInfo* item in careerList) {
                    if (item.cardType == 10) {
                        [typeList addObject:item];
                    }
                }
                break;
            default:
                break;
        }
    }
    [_filtedList addObjectsFromArray:typeList];
}

@end
