//
//  LeftMenuCell.h
//  HSCards
//
//  Created by song jufeng on 15/3/24.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuCell : UITableViewCell

@property(nonatomic, readonly)NSString* tagStr;

-(void)clearData;
-(void)loadCellData:(NSDictionary*)data;

@end
