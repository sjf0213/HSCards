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
@property(nonatomic, assign)NSUInteger rarity;
@property(nonatomic, assign)NSUInteger career;// 所属职业
@property(nonatomic, assign)NSUInteger atk;// 攻击力（随从和武器牌才有，法术牌没有）
@property(nonatomic, assign)NSUInteger health;// 生命值（随从和武器牌才有，法术牌没有）
@property(nonatomic, assign)NSUInteger durability;// 耐久度（武器牌专属）
@property(nonatomic, assign)NSUInteger collectible;// 是否衍生卡牌
@property(nonatomic, assign)NSUInteger cardType;// 卡牌类型（法术，随从，武器，英雄技能）

@property(nonatomic, assign)NSUInteger cardSet;


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
        _cardID = [dic objectForKey:@"CardID"];
        // 卡牌名称
        NSDictionary* dicTemp = [dic objectForKey:@"CardName"];
        if ([dicTemp isKindOfClass:[NSDictionary class]])
        {
            NSString* strTemp = [dicTemp objectForKey:@"zhCN"];
            if ([strTemp isKindOfClass:[NSString class]])
            {
                _cardName = strTemp;
            }
        }
        // 费用，法力值消耗
        num = [dic objectForKey:@"Cost"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cost = [num unsignedIntegerValue];
        }
        // 稀有程度
        num = [dic objectForKey:@"Rarity"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _rarity = [num unsignedIntegerValue];
        }
        // 所属职业
        num = [dic objectForKey:@"Class"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _career = [num unsignedIntegerValue];
        }
        // 是否衍生卡牌
        num = [dic objectForKey:@"Collectible"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _collectible = [num unsignedIntegerValue];
        }
        // 卡牌类型
        num = [dic objectForKey:@"CardType"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cardType = [num unsignedIntegerValue];
        }
        
        
        // 意义未知属性
        num = [dic objectForKey:@"CardSet"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cardSet = [num unsignedIntegerValue];
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
