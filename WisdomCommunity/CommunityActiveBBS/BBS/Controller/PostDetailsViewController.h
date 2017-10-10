//
//  PostDetailsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  帖子详情

#import <UIKit/UIKit.h>
#import "PostDetailsTableViewCell.h"

#import "SeeImageObj.h"
#import "SeeImagesView.h"

static CGRect oldframe;
@interface PostDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>


@property (nonatomic,strong) UITableView *PostDetailsTableView;//个人中心tableview
@property (nonatomic,strong) UITextView *inputMessageTextView;//消息输入框
@property (nonatomic,strong) UIView *backView;//背景图
@property (nonatomic,strong) UIButton *sendButtonInfor;//发送按钮
//tableview

@property (nonatomic,assign) NSInteger RecordClickPictureTag;//记录点击的图片tag值
@property (nonatomic,strong) NSMutableArray *PostDetailsAllarray;//总数据
@property (nonatomic,strong) NSMutableArray *PostDetailsModelarray;//总模型
@property (nonatomic,strong) NSMutableArray *PostDetailsHeight;//模型高度

@property (nonatomic,assign) float keyBoardHeight;//键盘自适应高度
@property (nonatomic,assign) float postHeight;//帖子内容高度


@property (nonatomic,strong) CYEmitterButton *thumbUpButton;//点赞
@property (nonatomic,weak) UIButton *toViewButton;//查看次数
@property (nonatomic,weak) UIButton *CommentButton;//评论按钮



//帖子文字内容和图片内容
//@property (nonatomic,strong) NSString *postString;
@property (nonatomic,strong) NSArray *postPictureArray;
@property (nonatomic,strong) YYTextLayout *postLayout;

@property (nonatomic,strong) PostDetailsTableViewCell *postCell;//cell

@property (nonatomic,strong) NSDictionary *BBSDetailsDict;//帖子详情

@end
