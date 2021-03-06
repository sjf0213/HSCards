//
//  CardListCell.m
//  HSCards
//
//  Created by song jufeng on 15/2/26.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardListCell.h"
#import "CardItemInfo.h"
#import "CommonDefine.h"
@interface CardListCell()
@property(nonatomic, strong)UIImageView* cardPic;
@property(nonatomic, strong)UILabel* cardID;
@property(nonatomic, strong)UILabel* cardName;
@property(nonatomic, strong)UILabel* cardCost;
@property(nonatomic, strong)UILabel* cardRarity;
@property(nonatomic, strong)UILabel* cardCareer;

@property(nonatomic, strong)UILabel* cardSet;
@property(nonatomic, strong)UILabel* cardType;
@property(nonatomic, strong)UILabel* collectible;
@end
@implementation CardListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x1 = 80.0;
        CGFloat x2 = ([UIScreen mainScreen].bounds.size.width - x1)*0.5 + x1;
        
        _cardPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 80)];
        _cardPic.image = nil;
        [self addSubview:_cardPic];
        
        _cardName = [[UILabel alloc] initWithFrame:CGRectMake(x1, 12, 190, 20)];
        _cardName.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardName.text = @"";
        _cardName.font = KA_COMMON_FONT_OF_SIZE(18);
        [self addSubview:_cardName];
        
        _cardID = [[UILabel alloc] initWithFrame:CGRectMake(x1, 38, 90, 14)];
        _cardID.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardID.text = @"";
        _cardID.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardID];
        
        // 第一行
        _cardCost = [[UILabel alloc] initWithFrame:CGRectMake(x1, 58, 100, 14)];
        _cardCost.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardCost.text = @"";
        _cardCost.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardCost];
        
        _cardRarity = [[UILabel alloc] initWithFrame:CGRectMake(x2, 58, 100, 14)];
        _cardRarity.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardRarity.text = @"";
        _cardRarity.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardRarity];
        
        // 第二行
        _cardCareer = [[UILabel alloc] initWithFrame:CGRectMake(x1, 76, 100, 14)];
        _cardCareer.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardCareer.text = @"";
        _cardCareer.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardCareer];
        
        _cardType = [[UILabel alloc] initWithFrame:CGRectMake(x2, 76, 100, 14)];
        _cardType.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
        _cardType.text = @"";
        _cardType.font = KA_COMMON_FONT_OF_SIZE(12);
        [self addSubview:_cardType];
        
        // 第三行
//        _collectible = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 50, 14)];
//        _collectible.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
//        _collectible.text = @"";
//        _collectible.font = KA_COMMON_FONT_OF_SIZE(12);
//        [self addSubview:_collectible];
        
//        _cardSet = [[UILabel alloc] initWithFrame:CGRectMake(180, 80, 50, 14)];
//        _cardSet.textColor = [UIColor colorWithWhite:110/255.0 alpha:1.0];
//        _cardSet.text = @"";
//        _cardSet.font = KA_COMMON_FONT_OF_SIZE(12);
//        [self addSubview:_cardSet];
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
    //_collectible.text = @"elite:";
    _cardCost.text = [NSString stringWithFormat:@"%@:",   NSLocalizedString(@"Cost", @"")];
    _cardRarity.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Rarity", @"")];
    _cardCareer.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Career", @"")];
    _cardType.text = [NSString stringWithFormat:@"%@:",   NSLocalizedString(@"CardType", @"")];
    _cardSet.text = [NSString stringWithFormat:@"%@:",    NSLocalizedString(@"CardSet", @"")];
}

-(void)loadCellData:(CardItemInfo*)data
{
    _cardPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",data.cardID]];
    _cardID.text = [NSString stringWithFormat:@"代码: %@",data.cardID];
    _cardName.text = data.cardName;
    //_collectible.text = [NSString stringWithFormat:@"elite: %zd", data.elite];;
    _cardCost.text = [NSString stringWithFormat:@"%@: %zd",NSLocalizedString(@"Cost", @""), data.cost];
    if ([data.rarity isKindOfClass:[NSString class]]){
        _cardRarity.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Rarity", @""), NSLocalizedString(data.rarity, @"")];
    }
    if ([data.career isKindOfClass:[NSString class]]){
        _cardCareer.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Career", @""), NSLocalizedString(data.career, @"")];
    }
    if ([data.cardType isKindOfClass:[NSString class]]){
        _cardType.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"CardType", @""), NSLocalizedString(data.cardType, @"")];
    }
    _cardSet.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"CardSet", @""), data.cardSet];
}

@end
