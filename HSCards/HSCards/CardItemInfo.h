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
-(id)initWithDic:(NSDictionary*)dic;

@end
