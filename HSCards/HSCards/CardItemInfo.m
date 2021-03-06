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
@property(nonatomic, assign)BOOL collectible;// 是否可收集
@property(nonatomic, assign)BOOL elite;//???

@property(nonatomic, assign)NSUInteger cost;// 费用，法力值消耗
@property(nonatomic, assign)NSUInteger attack;// 攻击力（随从和武器牌才有，法术牌没有）
@property(nonatomic, assign)NSUInteger health;// 生命值（随从牌专属）
@property(nonatomic, assign)NSUInteger durability;// 耐久度（武器牌专属）

@property(nonatomic, assign)NSString* rarity;// 稀有程度
@property(nonatomic, assign)NSString* cardType;// 卡牌类型（随从，法术，武器，英雄，英雄技能，XXX）
@property(nonatomic, assign)NSString* career;// 所属职业
@property(nonatomic, assign)NSString* race;// 所属种族
@property(nonatomic, assign)NSString* cardSet;//卡牌所属集合

@property(nonatomic, assign)NSString* howToGetGold;// 获得条件
@property(nonatomic, assign)NSString* flavor;// 调料包
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
        
        // 是否可收集
        num = [dic objectForKey:@"collectible"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _collectible = [num boolValue];
        }
        
        // ???
        num = [dic objectForKey:@"elite"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _elite = [num boolValue];
        }
        
        // 费用，法力值消耗
        num = [dic objectForKey:@"cost"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cost = [num unsignedIntegerValue];
        }
        // 攻击力
        num = [dic objectForKey:@"attack"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _attack = [num unsignedIntegerValue];
        }
        // 随从生命值
        num = [dic objectForKey:@"health"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _health = [num unsignedIntegerValue];
        }
        // 武器耐久度
        num = [dic objectForKey:@"durability"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _durability = [num unsignedIntegerValue];
        }
        
        // 稀有程度
        _rarity = [dic objectForKey:@"rarity"];
        
        // 种族
        _race = [dic objectForKey:@"race"];
        
        // 卡牌类型
        _cardType = [dic objectForKey:@"type"];
        
        // 卡牌描述
        _descText = [dic objectForKey:@"text"];
        
        // 获得条件
        _howToGetGold = [dic objectForKey:@"howToGetGold"];
        
        // 调料包
        _flavor = [dic objectForKey:@"flavor"];
        
        // 职业
        NSString* str = [dic objectForKey:@"playerClass"];
        if ([str isKindOfClass:[NSString class]]) {
            _career = str;
        }else{
            _career = @"Neutral"; // 默认值为中立
        }
    }
    return self;
}

-(void)setCardSet:(NSString *)cardSet
{
    _cardSet = cardSet;
}

-(void)setCardRarity:(NSString *)rarity
{
    _rarity = rarity;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"-----------!----------%@\n%@",_cardName, [_otherInfo description]];
    //return [NSString stringWithFormat:@"id:%@, name:%@, cost:%d, rarity:%d", _cardID, _cardName, _cost, _rarity];
}

-(BOOL)canMatchSearchText:(NSString*)text
{
    if ([_cardName containsString:text]) {
        return YES;
    }else if([_descText isKindOfClass:[NSString class]] &&
             [_descText containsString:text]){
        return YES;
    }
    return NO;
}

@end
