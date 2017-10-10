//
//  MyCommentModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的评论

#import <Foundation/Foundation.h>

@interface MyCommentModel : NSObject


@property (nonatomic,strong) NSString *headString;//
@property (nonatomic,strong) NSString *nameString;//
@property (nonatomic,strong) NSString *timeString;//
@property (nonatomic,strong) NSString *showImageString;//
@property (nonatomic,strong) NSString *commentPostString;//内容
@property (nonatomic,strong) NSString *comNameString;//评论对象
@property (nonatomic,strong) NSString *titleString;//标题

+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
