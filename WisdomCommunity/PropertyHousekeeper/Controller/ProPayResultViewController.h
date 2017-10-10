//
//  ProPayResultViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业缴费结果

#import <UIKit/UIKit.h>

@interface ProPayResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *ProPayResultTableView;//物业缴费结果页面

@property (nonatomic,strong) NSArray *promptArray;
@property (nonatomic,strong) NSArray *dataArray;
//@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *resultLabel;

@end
