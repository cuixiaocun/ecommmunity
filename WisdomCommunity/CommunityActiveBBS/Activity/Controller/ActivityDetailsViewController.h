//
//  ActivityDetailsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//  活动详情页

#import <UIKit/UIKit.h>
#import "PostDetailsTableViewCell.h"
#import "ActivityRootModel.h"
static CGRect oldAframe;
@interface ActivityDetailsViewController : UIViewController<UIWebViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>


@property (nonatomic,strong) UITableView *ActivityDetailsTableView;

@property (nonatomic,strong) UITextView *inputMessageADTextView;//消息输入框
@property (nonatomic,strong) UIView *backADView;//背景图
@property (nonatomic,strong) UIButton *sendButtonADInfor;//发送按钮
@property (nonatomic,assign) float keyADBoardHeight;//键盘自适应高度

@property (nonatomic,strong) UIButton *ActivityDeButton;//详情按钮
@property (nonatomic,strong) UIButton *commentDeButton;//评论按钮
@property (strong, nonatomic) UIView *customView;//移动动画
//顶部控件
@property (nonatomic,strong) UIView *ActivityDeTopView;//顶部视图
@property (nonatomic,strong) UIButton *ActivityDeTopButton;//详情按钮
@property (nonatomic,strong) UIButton *CommentDeTopButton;//评论按钮
@property (strong, nonatomic) UIView *CustomTopView;//移动动画
@property (nonatomic,strong) UIView *navigationView;//显示与隐藏的视图

@property (nonatomic,strong) NSMutableArray *ActivityAllDataArray;//评论总数据
@property (nonatomic,strong) NSMutableArray *ActivityAModelArray;//评论模型数据
@property (nonatomic,strong) NSMutableArray *ActivityAHeight;//评论模型高度

@property (nonatomic,strong) NSMutableArray *pictureArray;//图片数组

@property (nonatomic,strong) PostDetailsTableViewCell *AcDeCell;


@property (nonatomic,assign) float HtmlHeight;//高度
@property (nonatomic,strong) UIWebView *ShowWebViewHtml;//显示HTML代码
@property (nonatomic,strong) UIImageView *showImmage;//活动详情背景图
@property (nonatomic,strong) UIImageView *headImage;//活动详情头像
@property (nonatomic,strong) UILabel *timeLabel;//活动详情时间
@property (nonatomic,strong) UIImageView *showActivityImmage;//活动详情
@property (nonatomic,strong) NSString *ActivityIDmodel;

@end
