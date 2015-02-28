//
//  CardItemInfo.m
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardItemInfo.h"
@interface CardItemInfo()
@property(nonatomic, strong)NSString* cardName;
@property(nonatomic, strong)NSString* cardID;
@property(nonatomic, assign)NSUInteger cost;
@end
@implementation CardItemInfo

-(id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if(self)
    {
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
        NSNumber* num = [dic objectForKey:@"Cost"];
        if ([num isKindOfClass:[NSNumber class]]) {
            _cost = [num unsignedIntegerValue];
        }
        
    }
    return self;
}

@end
