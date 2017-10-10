//
//  SendCommentViewController.h
//  WisdomCommunity
//
//  Created by bridge on 17/2/4.
//  Copyright © 2017年 bridge. All rights reserved.
//  发表评论

#import <UIKit/UIKit.h>

@interface SendCommentViewController : UIViewController<UITextViewDelegate>

@property (nonatomic,strong) UITextView *postContentTextView;//帖子内容

@property (nonatomic,strong) NSString *shopId;//评价商家id
@property (nonatomic,strong) NSString *productStar;//商品评分
@property (nonatomic,strong) NSString *serveStar;//服务评分

@property (nonatomic,strong) UIView *redStartOne;//金星
@property (nonatomic,strong) UIView *redStartTwo;//金星

@end
