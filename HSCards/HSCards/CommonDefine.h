//
//  CommonDefine.h
//  HSCards
//
//  Created by song jufeng on 15/2/25.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#ifndef HSCards_CommonDefine_h
#define HSCards_CommonDefine_h

#import <Foundation/Foundation.h>

#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif


#define KA_COMMON_FONT_OF_SIZE(__SIZE__)   [UIFont fontWithName:@"HelveticaNeue-Light" size:__SIZE__]
#define KA_COMMON_BOLD_FONT_OF_SIZE(__SIZE__)   [UIFont fontWithName:@"HelveticaNeue" size:__SIZE__]

//#define SlidingAnchorRightPeekAmount 100.0
#define SlidingAnchorRightRevealAmount 200
#define SlidingAnchorLeftRevealAmount 250.0
#define MainList_Row_H   100
#define LeftMenu_Row_H   52

#define ColorLevel1 [UIColor colorWithRed:0.8 green:0.9 blue:0.95 alpha:1.0]
#define ColorLevel2 [UIColor colorWithRed:0.8 green:0.95 blue:0.9 alpha:1.0]

#define Notification_UpdateMainList   @"Notification_UpdateMainList"
#define Notification_EnableTopScroll  @"Notification_EnableTopScroll"
#endif
