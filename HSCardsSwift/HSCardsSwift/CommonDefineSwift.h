//
//  CommonDefineSwift.h
//  HSCardsSwift
//
//  Created by song jufeng on 15/5/15.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#ifndef HSCardsSwift_CommonDefineSwift_h
#define HSCardsSwift_CommonDefineSwift_h

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

#define Notification_UpdateMainList   @"Notification_UpdateMainList"
#define Notification_EnableTopScroll  @"Notification_EnableTopScroll"

#endif
