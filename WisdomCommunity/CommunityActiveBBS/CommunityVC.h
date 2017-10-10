//
//  CommunityVC.h
//  WisdomCommunity
//
//  Created by Admin on 2017/3/27.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
@interface CommunityVC :STableViewController<UITableViewDataSource,UITableViewDelegate >
{
    NSMutableArray *infoArray;  //存放列表数据
    NSMutableArray *themeArr;  //存放列表数据
    
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
    
}
@property (nonatomic,strong) NSDictionary *HotPostContentDict;//热门帖子数据


@end
