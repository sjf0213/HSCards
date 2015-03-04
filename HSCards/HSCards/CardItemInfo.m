//
//  CardItemInfo.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardItemInfo.h"
@interface CardItemInfo()
@property(nonatomic, strong)NSDictionary* otherInfo;
@property(nonatomic, strong)NSString* cardName;
@property(nonatomic, strong)NSString* cardID;
@property(nonatomic, assign)NSUInteger cost;
@property(nonatomic, assign)NSString* rarity;
@property(nonatomic, assign)NSString* cardType;// 卡牌类型（随从，法术，武器，英雄，英雄技能，XXX）
@property(nonatomic, assign)NSString* career;// 所属职业
@property(nonatomic, assign)NSString* race;// 所属种族
@property(nonatomic, assign)BOOL collectible;// 是否衍生卡牌
@property(nonatomic, assign)NSString*  cardSet;

@property(nonatomic, assign)NSUInteger attack;// 攻击力（随从和武器牌才有，法术牌没有）
@property(nonatomic, assign)NSUInteger health;// 生命值（随从和武器牌才有，法术牌没有）
@property(nonatomic, assign)NSUInteger durability;// 耐久度（武器牌专属）



@end
@implementation CardItemInfo

-(id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if(self)
    {
        NSNumber* num = nil;
        _otherInfo = dic;
        
        // 卡牌代码
        _cardID = [dic objectForKey:@"id"];
        // 卡牌名称
        _cardName = [dic objectForKey:@"name"];
        // 费用，法力值消耗
        num = [dic objectForKey:@"cost"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cost = [num unsignedIntegerValue];
        }
        // 稀有程度
        _rarity = [dic objectForKey:@"rarity"];
        // 所属职业
        _career = [dic objectForKey:@"playerClass"];
        // 种族
        _race = [dic objectForKey:@"race"];
        // 卡牌类型
        _cardType = [dic objectForKey:@"type"];
        // 是否可收集
        num = [dic objectForKey:@"collectible"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _collectible = [num boolValue];
        }
    }
    return self;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"-----------!----------%@\n%@",_cardName, [_otherInfo description]];
    //return [NSString stringWithFormat:@"id:%@, name:%@, cost:%d, rarity:%d", _cardID, _cardName, _cost, _rarity];
}

@end
