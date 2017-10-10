//
//  CZExhibitionDetailsController.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//  油画详情页

#import <UIKit/UIKit.h>
#import "CZExhibitionDetailsTopView.h"
#import "CZExhibitionDetailsSelectView.h"
#import "PostDetailsTableViewCell.h"
#import "CZExhibitionModel.h"
typedef NS_ENUM(NSInteger, DetailsExhibitionType){
    DetailsTypeOilPainting,
    DetailsTypeDecoration
};

@interface CZExhibitionDetailsController : UIViewController<
UITextViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIWebViewDelegate
>


@property ( nonatomic, assign) float                         keyADBoardHeight;//键盘自适应高度
@property ( nonatomic, strong) UITextView                    *inputMessageADTextView;//消息输入框
@property ( nonatomic, strong) UIButton                      *sendButtonADInfor;//发送按钮
@property ( nonatomic, strong) UIView                        *backADView;//背景图
@property ( nonatomic, copy  ) CZExhibitionModel             *model;
@property ( nonatomic, assign) DetailsExhibitionType         type;
@property ( nonatomic, strong) CZExhibitionDetailsSelectView *detailsSelectView;
@property ( nonatomic, strong) UITableView                   *tableView;
@property ( nonatomic, strong) UIWebView                     *webView;
@property ( nonatomic, assign) BOOL                          isComments;
@property ( nonatomic, strong) PostDetailsTableViewCell      *AcDeCell;
@property ( nonatomic, strong) NSMutableArray                *ActivityAModelArray;//评论模型数据
@property ( nonatomic, strong) NSMutableArray                *ActivityHeightArray;//评论高度
@property ( nonatomic, assign) float                         HtmlHeight;//高度

- (instancetype)initWithID:(CZExhibitionModel *)model andType:(DetailsExhibitionType )type;


@end
