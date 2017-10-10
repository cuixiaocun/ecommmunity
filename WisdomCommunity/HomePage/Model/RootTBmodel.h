//
//  RootTBmodel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootTBmodel : NSObject

@property (nonatomic,strong) NSString *headImageString;//头像
@property (nonatomic,strong) NSString *nameString;//名字
@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *comeString;//来自
@property (nonatomic,strong) NSString *contentString;//帖子内容
@property (nonatomic,strong) NSString *contentImageOne;//内容图片1
@property (nonatomic,strong) NSString *contentImageTwo;//内容图片1
@property (nonatomic,strong) NSString *contentImageThree;//内容图片1
@property (nonatomic,strong) NSString *pictureNumber;//照片总数
@property (nonatomic,strong) NSString *checkNumber;//查看次数
@property (nonatomic,strong) NSString *commentNumber;//评论次数
@property (nonatomic,strong) NSString *fabulousNumber;//赞的次数
@property (nonatomic,strong) NSString *postIdString;//帖子id

+ (instancetype) bodyWithDict:(NSMutableDictionary *)dict;
@end
