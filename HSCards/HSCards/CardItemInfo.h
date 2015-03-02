//
//  CardItemInfo.h
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardItemInfo : NSObject

@property(nonatomic, readonly)NSString* cardID;// 代码
@property(nonatomic, readonly)NSString* cardName;// 名称
@property(nonatomic, readonly)NSUInteger cost;// 费用，法力值消耗
@property(nonatomic, readonly)NSUInteger rarity;// 稀有程度
@property(nonatomic, readonly)NSUInteger career;// 所属职业
@property(nonatomic, readonly)NSUInteger atk;// 攻击力（随从和武器牌才有，法术牌没有）
@property(nonatomic, readonly)NSUInteger health;// 生命值（随从和武器牌才有，法术牌没有）
@property(nonatomic, readonly)NSUInteger durability;// 耐久度（武器牌专属）
@property(nonatomic, readonly)NSUInteger collectible;// 是否衍生卡牌
@property(nonatomic, readonly)NSUInteger cardType;// 卡牌类型（法术，随从，武器，英雄技能）

@property(nonatomic, readonly)NSUInteger cardSet;

-(id)initWithDic:(NSDictionary*)dic;

@end
