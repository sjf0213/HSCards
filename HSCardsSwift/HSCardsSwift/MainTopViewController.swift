//
//  MainTopViewController.swift
//  HSCardsSwift
//
//  Created by song jufeng on 15/5/14.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

import Foundation

class MainTopViewController:UIViewController
{
    var mainView:CardListView = CardListView()
    var searchBar:UISearchBar?
    var mask:UIView?
    override func loadView()
    {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.searchBar = UISearchBar(frame: CGRectMake(0, 64, self.view.frame.size.width, 44))
        self.view.addSubview(self.searchBar!)
        
        self.mask = UIView(frame: self.view.bounds)
        self.mask!.backgroundColor = UIColor(white: 0, alpha: 0.5)

        self.view.addSubview(self.mask!)
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisplayData) name:Notification_UpdateMainList object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableTopScroll:) name:Notification_EnableTopScroll object:nil];
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateDisplayData", name: Notification_UpdateMainList, object: nil)
    }
    
    func updateDisplayData()
    {
        NSLog("--------")
//        [[CardsBox shareInstance] fillFiltedList];
//        [self.mainView.arrayDataSource removeAllItems];
//        [self.mainView.arrayDataSource appendWithItems:[CardsBox shareInstance].filtedList];
//        [self.mainView reloadDisplayData];
//        self.navigationItem.title = [NSString stringWithFormat:@"共有 %zd 张卡牌", self.mainView.arrayDataSource.items.count];
    }
}