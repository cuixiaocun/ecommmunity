//
//  TakeOutViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  外卖、超市、微店、团购、菜市场首页

#import <UIKit/UIKit.h>
#import "TakeOutTableViewCell.h"
#import "MerchantsPageViewController.h"
@interface TakeOutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *TakeOutTableView;//外卖tableview
@property (nonatomic,strong) UIView *shadowView;//蒙版
@property (nonatomic,strong) UITableView *classificationTableView;//分类
@property (nonatomic,strong) NSArray *classDataArray;//分类数据
@property (nonatomic,strong) UITableView *sortingTableView;//排序
@property (nonatomic,strong) UITableView *brushChooseTableView;//刷选
@property (nonatomic,weak)   UIImageView *TakeOutPromptImage;//没有数据提示说明

@property (nonatomic,strong) NSMutableArray *allDataTOArray;//所有数据
@property (nonatomic,strong) NSMutableArray *allDataTOModelArray;//数据模型

@property (nonatomic,strong) UIButton *classificationButton;
@property (nonatomic,strong) UIButton *sortingButton;
@property (nonatomic,strong) UIButton *brushChooseButton;

@property (nonatomic,strong) NSString *ChooseClassificationString;//外卖，超市，菜市场等标签
@property (nonatomic,strong) NSString *LabelCategoryId;//标签id

@property (nonatomic,strong) TakeOutTableViewCell *takeCell;

@end
