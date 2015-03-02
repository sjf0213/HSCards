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
@property(nonatomic, strong)UIImageView* cardPic;
@property(nonatomic, strong)UILabel* cardID;
@property(nonatomic, strong)UILabel* cardName;
@property(nonatomic, strong)UILabel* cardCost;
@property(nonatomic, strong)UILabel* cardRarity;

@property(nonatomic, strong)UILabel* cardSet;
@property(nonatomic, strong)UILabel* cardType;
@property(nonatomic, strong)UILabel* cardClass;
@property(nonatomic, strong)UILabel* collectible;
@end
@implementation CardListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _cardPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 80)];
        _cardPic.image = nil;
        [self addSubview:_cardPic];
        
        _cardName = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, 190, 20)];
        _cardName.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardName.text = @"";
        _cardName.font = KA_COMMON_FONT_OF_SIZE(18);
        [self addSubview:_cardName];
        
        _cardID = [[UILabel alloc] initWithFrame:CGRectMake(80, 34, 90, 14)];
        _cardID.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardID.text = @"";
        _cardID.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardID];
        
        _cardCost = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 50, 14)];
        _cardCost.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardCost.text = @"";
        _cardCost.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardCost];
        
        _cardRarity = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 50, 14)];
        _cardRarity.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardRarity.text = @"";
        _cardRarity.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardRarity];
        
        
        _cardSet = [[UILabel alloc] initWithFrame:CGRectMake(80, 64, 50, 14)];
        _cardSet.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardSet.text = @"";
        _cardSet.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardSet];
        
        _cardType = [[UILabel alloc] initWithFrame:CGRectMake(130, 64, 50, 14)];
        _cardType.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardType.text = @"";
        _cardType.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardType];
        
        _cardClass = [[UILabel alloc] initWithFrame:CGRectMake(180, 64, 50, 14)];
        _cardClass.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardClass.text = @"";
        _cardClass.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardClass];
        
        _collectible = [[UILabel alloc] initWithFrame:CGRectMake(230, 64, 50, 14)];
        _collectible.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _collectible.text = @"";
        _collectible.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_collectible];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)clearData
{
    _cardPic.image = nil;
    _cardID.text = @"";
    _cardName.text = @"";
    _cardCost.text = @"";
    _cardRarity.text = @"";
    
    _cardSet.text = @"";
    _cardType.text = @"";
    _cardClass.text = @"";
    _collectible.text = @"";
}

-(void)loadCellData:(CardItemInfo*)data
{
    _cardPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",data.cardID]];
    _cardID.text = data.cardID;
    _cardName.text = data.cardName;
    _cardCost.text = [NSString stringWithFormat:@"费: %zd", data.cost];
    _cardRarity.text = [NSString stringWithFormat:@"稀: %zd", data.rarity];
    
    _cardSet.text = [NSString stringWithFormat:@"set: %zd", data.cardSet];
    _cardType.text = [NSString stringWithFormat:@"type: %zd", data.cardType];
    _cardClass.text = [NSString stringWithFormat:@"cls: %zd", data.cardClass];
    _collectible.text = [NSString stringWithFormat:@"coll: %zd", data.collectible];;
}

@end
