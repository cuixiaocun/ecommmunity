//
//  MerchantsPageViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  商家页面

#import <UIKit/UIKit.h>
#import "MerchantsTableViewCell.h"
#import "GoodsTypeTableViewCell.h"
#import "MerchantsCommentTableViewCell.h"
#import "ShopListTableViewCell.h"
#import "GoodsDetailsViewController.h"//商品详情页
#import "SubmitMOrderViewController.h"//提交订单
#import "MerchantsHeadView.h"
#import "MercahntsPageDataDealW.h"
@interface MerchantsPageViewController : UIViewController<CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource,MenuItemCellDelegate,DetailListCellDelegate>
{
    
    CGFloat _endPoint_x;
    CGFloat _endPoint_y;
    UIBezierPath *_path;
    CALayer *_dotLayer;
    
}
@property (nonatomic,strong) UIView *navigationMView;//显示与隐藏的视图
//首页展示
//@property (nonatomic,strong) UIView *headView;//头部view
@property (nonatomic,strong) MerchantsHeadView *headView;//头部view
@property (nonatomic,strong) NSDictionary *MerchantsDetailsDict;//商品详情字典

@property (nonatomic,strong) NSString *MerchantsId;//商家id
@property (nonatomic,strong) UIView *backView;//整体存放商品view
@property (nonatomic,strong) UIButton *goodsButton;//商品
@property (nonatomic,strong) UIButton *commentButton;//评价


@property (nonatomic,strong) UITableView *GoodsTypeTableView;//商品分类
@property (nonatomic,assign) float GoodsTypeY;//Type滑动的高度
@property (nonatomic,assign) BOOL whetherTypeScroll;//是否允许滑动

@property (nonatomic,strong) UITableView *GoodsPlistTableView;//商品列表
@property (nonatomic,assign) float GoodsPlistY;//Plis滑动的高度
@property (nonatomic,assign) BOOL whetherPlistScroll;//是否允许滑动
@property (nonatomic,assign) BOOL whetherMiddle;//是否在中间位置

@property (nonatomic,strong) UIView *shoppingBarView;//购物栏
@property (nonatomic,weak)   UIImageView *shopCartImage;//购物车图标
@property (nonatomic,weak)   UIImageView *selectImage;//商品数量背景
@property (nonatomic,weak)   UILabel *selectNumberLabel;//选择商品数
@property (nonatomic,weak)   UILabel *selectPriceLabel;//商品总价
@property (nonatomic,weak)   UILabel *sendMoneyLabel;//配送费
@property (nonatomic,weak)   UIButton *confirmButton;
@property (nonatomic,strong) NSMutableArray *GoodsTypeArray;//商品分类列表
@property (nonatomic,strong) NSMutableArray *GoodsPlistModelArray;//商品列表

@property (nonatomic,strong) UIView *maskView;//蒙版view
@property (nonatomic,strong) UIView *promptView;//提示view
@property (nonatomic,strong) UITableView *shopListTableView;//购物车列表
@property (nonatomic,strong) NSMutableArray *shopListArray;//购物车数组
//商家评价
@property (nonatomic,strong) NSMutableArray *commentArray;//评价总数据
@property (nonatomic,assign) float commentPlistY;//Plis滑动的高度
@property (nonatomic,assign) BOOL whetherCommentScroll;//是否允许滑动

@property (nonatomic,strong) NSMutableArray *commentHighArray;//评论高度
@property (nonatomic,strong) UITableView *GoodsCommentTableView;//评论列表
@property (nonatomic,strong) UILabel *commentNumberLabel;//评分
@property (nonatomic,strong) PKYStepper *hideButtonStepper;



@property (nonatomic,strong) NSString *SGoodsMoney;//商品价格

@property (nonatomic,strong) Singleton *goodsSing;
//cell
@property (nonatomic,strong) MerchantsTableViewCell *merchantsCell;
@property (nonatomic,strong) GoodsTypeTableViewCell *GoodsCell;
@property (nonatomic,strong) MerchantsCommentTableViewCell *commentCell;
@property (nonatomic,strong) ShopListTableViewCell *shopCell;


@end
