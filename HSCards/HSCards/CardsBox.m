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
    for (CardItemInfo* item in _cardList) {
        switch ([FilterData shareInstance].cost) {
            case mana_cost_all:
                [_filtedList addObjectsFromArray:_cardList];
                break;
            case mana_cost_0:
                if (item.cost == 0) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_1:
                if (item.cost == 1) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_2:
                if (item.cost == 2) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_3:
                if (item.cost == 3) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_4:
                if (item.cost == 4) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_5:
                if (item.cost == 5) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_6:
                if (item.cost == 6) {
                    [_filtedList addObject:item];
                }
                break;
            case mana_cost_7P:
                if (item.cost > 6) {
                    [_filtedList addObject:item];
                }
                break;
                
            default:
                break;
        }
        
    }
    
}

@end
