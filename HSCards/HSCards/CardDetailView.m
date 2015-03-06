//
//  CardDetailView.m
//  HSCards
//
//  Created by song jufeng on 15/3/6.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardDetailView.h"
#import "CardItemInfo.h"
@interface CardDetailView()
@property(nonatomic, strong)UIImageView* cardImage;
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
        _cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width - 250), 64, 250, 355)];
        [self addSubview:_cardImage];
    }
    _cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", info.cardID]];
    
}
@end
