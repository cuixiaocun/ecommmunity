//
//  IntegralCommunityViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区积分

#import <UIKit/UIKit.h>

@interface IntegralCommunityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *IntegralTableView;//个人中心tableview
@property (nonatomic,strong) UIButton *btnLeft;
@property (nonatomic,weak)   UILabel *promptLabel;//提示没有数据

@property (nonatomic,strong) NSMutableArray *integralArray;//积分数组



@end
