//
//  CardListCell.m
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardListCell.h"
#import "CommonDefine.h"
@interface CardListCell()
@property(nonatomic, strong)UILabel* cardName;
@end
@implementation CardListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cardName = [[UILabel alloc] initWithFrame:CGRectMake(64, 12, 190, 20)];
        self.cardName.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        self.cardName.text = @"";
        self.cardName.font = KA_COMMON_FONT_OF_SIZE(18);
        [self addSubview:self.cardName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)clearData
{
    self.cardName.text = @"";
}

-(void)loadCellData:(CardItemInfo*)data
{
    self.cardName.text = data.cardName;
}

@end
