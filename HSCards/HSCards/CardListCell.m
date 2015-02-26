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
@property(nonatomic, strong)UILabel* cardID;
@property(nonatomic, strong)UILabel* cardName;
@property(nonatomic, strong)UIImageView* cardPic;
@end
@implementation CardListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cardID = [[UILabel alloc] initWithFrame:CGRectMake(80, 32, 190, 20)];
        _cardID.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardID.text = @"";
        _cardID.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardID];
        
        _cardName = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, 190, 20)];
        _cardName.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardName.text = @"";
        _cardName.font = KA_COMMON_FONT_OF_SIZE(18);
        [self addSubview:_cardName];
        
        _cardPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 80)];
        _cardPic.image = nil;
        [self addSubview:_cardPic];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)clearData
{
    _cardID.text = @"";
    _cardName.text = @"";
    _cardPic.image = nil;
}

-(void)loadCellData:(CardItemInfo*)data
{
    _cardID.text = data.cardID;
    _cardName.text = data.cardName;
    _cardPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",data.cardID]];
}

@end
