//
//  CardItemInfo.h
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardItemInfo : NSObject

@property(nonatomic, readonly)NSString* cardID;
@property(nonatomic, readonly)NSString* cardName;

-(id)initWithDic:(NSDictionary*)dic;

@end
