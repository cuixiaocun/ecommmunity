//
//  CommunityABBSViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区大小事主页

#import <UIKit/UIKit.h>
#import "comBBSTableViewCell.h"
#import "BBSRootViewController.h"//帖子
#import "ActicityRootViewController.h"
@interface CommunityABBSViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *comBBSTableView;//tableview

@property (nonatomic,strong) UIView *selectLabelInTView;//tableview上按钮
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *middleButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *selectLabelAtTop;//顶端按钮
@property (nonatomic,strong) UIButton *leftTopButton;
@property (nonatomic,strong) UIButton *middleTopButton;
@property (nonatomic,strong) UIButton *rightTopButton;

//@property (nonatomic,strong) NSMutableArray *comDataBBSarray;//总数据
@property (nonatomic,weak)   UILabel *HotLabelPost;//热门帖子
@property (nonatomic,strong) NSDictionary *HotPostContentDict;//热门帖子数据

@property (nonatomic,assign) BOOL whetherClickLabelRequest;//是否是点击了标签栏进行的数据请求，YES：不提示没有数据；NO：提示没有数据

@property (nonatomic,weak) UIImageView *showImmage;//帖子
@property (nonatomic,weak) UIButton *topicButton;//话题
@property (nonatomic,strong) NSString *BBSRootLabelString;//按钮标签
//热点
@property (nonatomic,strong) NSMutableArray *comAllBBSarray;//总数据
@property (nonatomic,strong) NSMutableArray *comModelBBSarray;//数据模型
@property (nonatomic,strong) NSMutableArray *comTBHeightarray;//每个cell高度
@property (nonatomic,assign) NSInteger recordRequesPage;//记录请求页数
//分享
@property (nonatomic,strong) NSMutableArray *comAllSBBSarray;//总数据
@property (nonatomic,strong) NSMutableArray *comSModelBBSarray;//数据模型
@property (nonatomic,strong) NSMutableArray *comSTBHeightarray;//每个cell高度
@property (nonatomic,assign) NSInteger recordSRequesPage;//记录请求页数
//集市
@property (nonatomic,strong) NSMutableArray *comAllBBBSarray;//总数据
@property (nonatomic,strong) NSMutableArray *comBModelBBSarray;//数据模型
@property (nonatomic,strong) NSMutableArray *comBTBHeightarray;//每个cell高度
@property (nonatomic,assign) NSInteger recordBRequesPage;//记录请求页数


@property (nonatomic,strong) NSArray *ClickPRootCellData;//点击cell数据

@property (nonatomic,strong) comBBSTableViewCell *cell;

@end
