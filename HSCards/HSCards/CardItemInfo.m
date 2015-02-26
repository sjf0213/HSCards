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
@end
@implementation CardItemInfo

-(id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if(self)
    {
        NSDictionary* dicTemp = [dic objectForKey:@"CardName"];
        if ([dicTemp isKindOfClass:[NSDictionary class]])
        {
            NSString* strTemp = [dicTemp objectForKey:@"zhCN"];
            if ([strTemp isKindOfClass:[NSString class]])
            {
                _cardName = strTemp;
            }
        }
    }
    return self;
}

@end
