//
//  PostDetailsModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  帖子详情页 评论

#import <Foundation/Foundation.h>

@interface PostDetailsModel : NSObject


@property (nonatomic,strong) NSString *headImageString;//头像
@property (nonatomic,strong) NSString *nameString;//名字
@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *postString;//帖子内容

+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
