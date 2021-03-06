//
//  LeftMenuCell.m
//  HSCards
//
//  Created by song jufeng on 15/3/24.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "LeftMenuCell.h"
@interface LeftMenuCell()
@property(nonatomic, strong)NSString* tagStr;
@end
@implementation LeftMenuCell
//{
//    NSString* tagStr;
//}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor cyanColor];
        self.textLabel.textColor = [UIColor colorWithRed:76/255.0 green:80/255.0 blue:98/255.0 alpha:1.0];
        
    }
    return self;
}

-(void)clearData
{
    self.textLabel.text = @"";
    self.tagStr = nil;
}

-(void)loadCellData:(NSDictionary*)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        self.textLabel.text = NSLocalizedString([data objectForKey:@"title"],@"");
        self.tagStr = [data objectForKey:@"tag"];
    }
}

@end
