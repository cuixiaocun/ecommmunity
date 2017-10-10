//
//  SearchViewController.h
//  bridgeProject
//
//  Created by bridge on 16/5/20.
//  Copyright © 2016年 bridge. All rights reserved.
//  搜索商品

#import <UIKit/UIKit.h>
#import "TakeOutTableViewCell.h"
@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISearchBar *bar;//搜索框
//@property (nonatomic)        UIBarStyle barStyle;//搜索风格
//@property (nonatomic,strong) NSString *searchText;//内容
//@property(nonatomic,strong)  NSString *prompt;//背景文字
//@property(nonatomic,copy)    NSString *placeholder;//水印文字
//@property(nonatomic)         BOOL showsCancelButton;//是否显示取消按钮，默认为NO
//@property(nonatomic)         BOOL showsSearchResultsButton;//是否显示搜索结果按钮，默认为NO

//--------test-------

@property (nonatomic,strong) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *searchArray;//模型数据
@property(strong, nonatomic) NSArray *AllSearchArray;//原始数据

//搜索按钮
-(void) onClickSearch:(UIButton *)sender;


@property (nonatomic,strong) TakeOutTableViewCell *takeCell;
@end
