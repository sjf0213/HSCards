//
//  FilterListCell.m
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "FilterListCell.h"
#import "CommonDefine.h"
@interface FilterListCell()
@property(nonatomic, strong)UILabel* title;
@end
@implementation FilterListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
        _title.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _title.text = @"";
        _title.font = KA_COMMON_FONT_OF_SIZE(15);
        [self addSubview:_title];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)clearData
{
    _title.text = @"";
}

-(void)loadCellData:(NSDictionary*)data
{
    _title.text = [data objectForKey:@"title"];
}


@end
