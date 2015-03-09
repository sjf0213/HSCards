//
//  CardDetailView.m
//  HSCards
//
//  Created by song jufeng on 15/3/6.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardDetailView.h"
#import "CardItemInfo.h"
#import "CommonDefine.h"
@interface CardDetailView()
@property(nonatomic, strong)UIScrollView* mainScroll;
@property(nonatomic, strong)UIImageView* cardImage;
@property(nonatomic, strong)UILabel* careerLabel;
@property(nonatomic, strong)UILabel* howtogetLabel;
@property(nonatomic, strong)UILabel* flavorLabel;
@end

@implementation CardDetailView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        UIButton* backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
        backBtn.layer.cornerRadius = 3.0f;
        backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        backBtn.layer.borderWidth = 0.5f;
        
        //backBtn.backgroundColor = [UIColor cyanColor];
        [backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 64)];
        //_mainScroll.contentSize = CGSizeMake(self.bounds.size.width, 1000);
        [self addSubview:_mainScroll];
    }
    return self;
}

-(void)onBack
{
    if (self.didDismissHandler) {
        self.didDismissHandler();
    }
}

-(void)loadCardInfo:(CardItemInfo*)info
{
    if (nil == _cardImage) {
        _cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width - 250), 0, 250, 355)];
        [_mainScroll addSubview:_cardImage];
    }
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", info.cardID]];
    if (nil == _careerLabel) {
        _careerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width - 200), 355+20, 200, 16)];
        _careerLabel.textColor = [UIColor whiteColor];
        _careerLabel.font = KA_COMMON_BOLD_FONT_OF_SIZE(14);
        [_mainScroll addSubview:_careerLabel];
    }
    _careerLabel.text = [NSString stringWithFormat:@"职业: %@", info.career];
    
    CGRect flavorRect;
    if ([info.flavor isKindOfClass:[NSString class]]) {
        if (nil == _flavorLabel) {
            _flavorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width - 200), 355+40, 200, 60)];
            _flavorLabel.textColor = [UIColor whiteColor];
            _flavorLabel.font = KA_COMMON_BOLD_FONT_OF_SIZE(14);
            _flavorLabel.numberOfLines = 0;
            [_mainScroll addSubview:_flavorLabel];
            
        }
        _flavorLabel.text = [NSString stringWithFormat:@"加料: %@", info.flavor];
        NSDictionary *attribute = @{NSFontAttributeName: _flavorLabel.font};
        flavorRect = [_flavorLabel.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:attribute
                                                      context:nil];
        _flavorLabel.frame = CGRectMake(_flavorLabel.frame.origin.x, _flavorLabel.frame.origin.y, _flavorLabel.frame.size.width, flavorRect.size.height);
        _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width, _flavorLabel.frame.origin.y + _flavorLabel.frame.size.height + 4);
    }
    if ([info.howToGet isKindOfClass:[NSString class]]) {
        if (nil == _howtogetLabel) {
            _howtogetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width - 200), _flavorLabel.frame.origin.y + flavorRect.size.height + 4, 200, 60)];
            _howtogetLabel.textColor = [UIColor whiteColor];
            _howtogetLabel.font = KA_COMMON_BOLD_FONT_OF_SIZE(14);
            _howtogetLabel.numberOfLines = 0;
            [_mainScroll addSubview:_howtogetLabel];
        }
        _howtogetLabel.text = [NSString stringWithFormat:@"获得金卡条件: %@", info.howToGet];
        NSDictionary *attribute = @{NSFontAttributeName: _howtogetLabel.font};
        CGRect goldRect = [_howtogetLabel.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:attribute
                                                      context:nil];
        _howtogetLabel.frame = CGRectMake(_howtogetLabel.frame.origin.x, _howtogetLabel.frame.origin.y , _howtogetLabel.frame.size.width,  goldRect.size.height);
        _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width, _howtogetLabel.frame.origin.y + _howtogetLabel.frame.size.height + 4);
    }
}
@end
