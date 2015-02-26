//
//  CardListCell.h
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardItemInfo.h"

@interface CardListCell : UITableViewCell
-(void)clearData;
-(void)loadCellData:(CardItemInfo*)data;
@end
