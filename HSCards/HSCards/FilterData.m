//
//  FilterData.m
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "FilterData.h"

@interface FilterData()

@end

static FilterData * m_Instance;

@implementation FilterData

+(FilterData*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_Instance= [[FilterData alloc] initSingleton];
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
        NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"];
        _displayTextArray = [NSArray arrayWithContentsOfFile:dataPath];
    }
    return self;
}

@end
