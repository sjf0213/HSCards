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
@property(nonatomic, readonly)BOOL collectible;// 是否衍生卡牌

@property(nonatomic, readonly)NSUInteger cost;// 费用，法力值消耗
@property(nonatomic, readonly)NSUInteger attack;// 攻击力（随从和武器牌才有，法术牌没有）
@property(nonatomic, readonly)NSUInteger health;// 生命值（随从牌专属）
@property(nonatomic, readonly)NSUInteger durability;// 耐久度（武器牌专属）

@property(nonatomic, readonly)NSString* rarity;// 稀有程度
@property(nonatomic, readonly)NSString* cardType;// 卡牌类型（随从，法术，武器，英雄，英雄技能，XXX）
@property(nonatomic, readonly)NSString* career;// 所属职业
@property(nonatomic, readonly)NSString* race;// 所属种族：鱼人，机械等
@property(nonatomic, readonly)NSString* cardSet;// 卡牌来源集合（纳克萨玛斯等）

-(id)initWithDic:(NSDictionary*)dic;

@end
