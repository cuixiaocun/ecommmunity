//
//  GoodsDetailsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  商品详情

#import <UIKit/UIKit.h>
#import "MerchantsCommentTableViewCell.h"
#import "MerchantsModel.h"
@interface GoodsDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *backTopView;//导航栏

@property (nonatomic,strong) UITableView *GoodsDetailsTableView;//
@property (nonatomic,strong) NSMutableArray *detailsCommentArray;//商品详情页评论
@property (nonatomic,strong) NSMutableArray *detailsCommentHeight;//高度


@property (nonatomic,strong) UIImageView *showImmage;
@property (nonatomic,strong) PKYStepper *hideButtonStepper;
@property (nonatomic,strong) UIImageView *promptImmage;
@property (nonatomic,strong) UIImageView *commentImmage;
@property (nonatomic,strong) UIImageView *goodsImmage;
@property (nonatomic,strong) UILabel *commentNumberLabel;//评分

@property (nonatomic,strong) UILabel *GoodsLabel;

@property (nonatomic,strong) NSString *GoodsIdString;//商品id
@property (nonatomic,strong) NSString *MerchantsId;//商家id
@property (nonatomic,strong) NSDictionary *GoodsDetailsDict;//商品详情数据


@property (nonatomic,strong) MerchantsModel *model;//传进来的商品模型
@property (nonatomic,strong) MerchantsCommentTableViewCell *merchantsCell;


@end
