//
//  CardListView.m
//  HSCards
//
//  Created by song jufeng on 15/5/12.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "CardListView.h"
#import "CardListCell.h"
#import "CommonDefine.h"
#import "CardDetailViewController.h"
#import "ArrayDataSource.h"
#import "CardsBox.h"

@interface CardListView()<UITableViewDelegate>
@property(nonatomic, strong)UITableView* mainTable;
@property(atomic, strong) ArrayDataSource *arrayDataSource;
@end

@implementation CardListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        TableViewCellConfigureBlock configureCell = ^(CardListCell *cell, CardItemInfo *data) {
            [cell clearData];
            [cell loadCellData:data];
        };
        _arrayDataSource = [[ArrayDataSource alloc] initWithcellIdentifier:CardListCellIdentifier configureCellBlock:configureCell];
    
        _mainTable = [[UITableView alloc] initWithFrame:self.bounds];
        _mainTable.rowHeight = MainList_Row_H;
        _mainTable.dataSource = _arrayDataSource;
        _mainTable.delegate = self;
        [_mainTable registerClass:[CardListCell class] forCellReuseIdentifier:CardListCellIdentifier];
        _mainTable.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
        _mainTable.scrollIndicatorInsets = _mainTable.contentInset;
        [self addSubview:_mainTable];
    }
    return self;
}

-(void)updateDisplayData
{
    [[CardsBox shareInstance] fillFiltedList];
    [self.arrayDataSource removeAllItems];
    [self.arrayDataSource appendWithItems:[CardsBox shareInstance].filtedList];
    [self.mainTable reloadData];
    /*
    // 打印前N个卡牌
    {
        int n = [CardsBox shareInstance].filtedList.count;
        n = n > 50 ? 50 : n;
        for (int i = 0; i < n; i++)
        {
            CardItemInfo* obj = [CardsBox shareInstance].filtedList[i];
            DLog(@"obj = %@", obj);
        }
    }
    // 打印某种属性的所有枚举
    {
        NSMutableArray* arr = [NSMutableArray array];
        for (CardItemInfo* item in [CardsBox shareInstance].filtedList)
        {
            NSString* str = item.race;
            if ([str isKindOfClass:[NSString class]])
            {
                if (0 == arr.count) {
                    [arr addObject:str];
                }else{
                    if ([str isKindOfClass:[NSString class]]){
                        for (int i = 0; i < arr.count; i++){
                            NSString* alreadyHave = arr[i];
                            if ([str isEqualToString:alreadyHave]){
                                break;
                            }
                            if (i == arr.count - 1){
                                [arr addObject:str];
                            }
                        }
                    }
                }
            }
        }
        DLog(@"--------------------*---race.arr = %@", arr);
    }*/
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardItemInfo* info = [self.arrayDataSource itemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(onShowCardDetail:)]) {
        [self.delegate onShowCardDetail:info];
    }
    
}
@end
