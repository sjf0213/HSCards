//
//  FilterListCell.h
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterListCell : UITableViewCell
-(void)clearData;
-(void)loadCellData:(NSDictionary*)data;
@end
