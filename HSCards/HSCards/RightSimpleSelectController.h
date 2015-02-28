//
//  RightSimpleSelectController.h
//  HSCards
//
//  Created by song jufeng on 15/2/27.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayDataSource.h"

@interface RightSimpleSelectController : UIViewController

@property(atomic, strong) ArrayDataSource *arrayDataSource;

-(id)initWithDataArray:(NSArray*)arr;
-(void)reloadData;

@end
