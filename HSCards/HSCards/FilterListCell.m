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
@property(nonatomic, strong)UILabel* optResult;
@end
@implementation FilterListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
        _title.textColor = [UIColor colorWithRed:76/255.0 green:80/255.0 blue:98/255.0 alpha:1.0];
        _title.text = @"";
        _title.font = KA_COMMON_FONT_OF_SIZE(15);
        [self addSubview:_title];
        
        _optResult = [[UILabel alloc] initWithFrame:CGRectMake(SlidingAnchorLeftRevealAmount-135, 10, 100, 40)];
        _optResult.textColor = [UIColor colorWithRed:76/255.0 green:80/255.0 blue:98/255.0 alpha:1.0];
        _optResult.textAlignment = NSTextAlignmentRight;
        _optResult.text = @"";
        _optResult.font = KA_COMMON_FONT_OF_SIZE(15);
        [self addSubview:_optResult];
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
    _optResult.text = @"";
}

-(void)loadCellData:(NSDictionary*)data
{
    _title.text = NSLocalizedString([data objectForKey:@"title"], @"");
    _optResult.text = NSLocalizedString([data objectForKey:@"result"], @"");
}

@end
