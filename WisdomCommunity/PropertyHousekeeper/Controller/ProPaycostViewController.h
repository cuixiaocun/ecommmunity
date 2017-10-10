//
//  ProPaycostViewController.h
//  WisdomCommunity
//
//  Created by Admin on 2017/5/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProPaycostViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *HouseComTableView;//房屋展示
@property (nonatomic,strong) UITableView *YearTableView;//年份展示
@property (nonatomic,strong) NSMutableArray *HouseComArray;//物业公司数组信息
@property (nonatomic,strong) NSMutableArray *showYearArray;//显示的年份
@property (nonatomic,strong) NSString *selectBuild;//房号
@property (nonatomic,strong) NSString *selectProComId;//选择物业公司的id

@end
