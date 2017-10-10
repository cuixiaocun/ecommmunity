//
//  NNSRootModelData.m
//  WisdomCommunity
//
//  Created by bridge on 17/1/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "NNSRootModelData.h"

@implementation NNSRootModelData

//初始化数据
+ (NSArray *) initBBSRootModel:(NSArray *)array
{
    NSMutableArray *BBSRootAllarray = [[NSMutableArray alloc] init];
    NSMutableArray *BBSHeightArray = [[NSMutableArray alloc] init];
    NSMutableArray *modelBBSRootarray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *postDict = array[i];//帖子总数据
        [BBSRootAllarray addObject:postDict];//添加到总数据
        //图片信息
        NSString *pictureString = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"imgAddress"]];
        if (pictureString.length <= 6)
        {
            [BBSHeightArray addObject:[NSString stringWithFormat:@"%f",60*CXCWidth-24*CXCWidth+136*CXCWidth+78*2*CXCWidth+26*CXCWidth]];
        }
        else
            [BBSHeightArray addObject:[NSString stringWithFormat:@"%f",CXCWidth*204+60*CXCWidth+136*CXCWidth+78*2*CXCWidth+26*CXCWidth]];
        NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithDictionary:[NNSRootModelData  delaWithPostData:postDict]];
        comBBSModel *model = [comBBSModel bodyWithDict:dict2];
        [modelBBSRootarray addObject:model];
    }
    return @[BBSRootAllarray,BBSHeightArray,modelBBSRootarray];
}
//处理数据
+ (NSDictionary *) delaWithPostData:(NSDictionary *)postDict
{
    //图片信息
    NSString *pictureString = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"imgAddress"]];
    NSArray *pictureArray = [pictureString componentsSeparatedByString:@","];
    NSString *imageOne = @"";
    NSString *imageTwo = @"";
    NSString *imageThree = @"";
    for (NSInteger i = 0; i < pictureArray.count; i ++)
    {
        if (i == 0)
        {
            imageOne = pictureArray[0];
        }
        else if (i == 1)
        {
            imageTwo = pictureArray[1];
        }
        else if (i == 2)
        {
            imageThree = pictureArray[2];
        }
    }
    NSString *accountDoString = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"accountDO"]];
    NSDictionary *dict;//显示帖子数据
    if (accountDoString.length > 6)
    {
        //发帖人信息
        NSDictionary *sendPersonalDict = [postDict objectForKey:@"accountDO"];//发帖人信息
        //信息
        dict = @{
                 @"headImageString":[sendPersonalDict objectForKey:@"imgAddress"],
                 @"nameString":[sendPersonalDict objectForKey:@"nickName"],
                 @"timeString":[CYSmallTools timeWithTimeIntervalString:[postDict objectForKey:@"gmtCreate"]],
                 @"comeString":[postDict objectForKey:@"communityName"],
                 @"contentString":[postDict objectForKey:@"title"],
                 @"contentImageOne":imageOne,
                 @"contentImageTwo":imageTwo,
                 @"contentImageThree":imageThree,
                 @"pictureNumber":pictureArray.count > 2 ? [NSString stringWithFormat:@"%ld",pictureArray.count] : @"",
                 @"checkNumber":[postDict objectForKey:@"viewCount"],
                 @"commentNumber":[postDict objectForKey:@"replyCount"],
                 @"fabulousNumber":[postDict objectForKey:@"praiseCount"],
                 @"postIdString":[postDict objectForKey:@"id"]
                 };
    }
    else
    {
        //信息
        dict = @{
                 @"headImageString":DefaultHeadImage,
                 @"nameString":@"未获取",
                 @"timeString":[CYSmallTools timeWithTimeIntervalString:[postDict objectForKey:@"gmtCreate"]],
                 @"comeString":[postDict objectForKey:@"communityName"],
                 @"contentString":[postDict objectForKey:@"title"],
                 @"contentImageOne":imageOne,
                 @"contentImageTwo":imageTwo,
                 @"contentImageThree":imageThree,
                 @"pictureNumber":pictureArray.count > 2 ? [NSString stringWithFormat:@"%ld",pictureArray.count] : @"",
                 @"checkNumber":[postDict objectForKey:@"viewCount"],
                 @"commentNumber":[postDict objectForKey:@"replyCount"],
                 @"fabulousNumber":[postDict objectForKey:@"praiseCount"],
                 @"postIdString":[postDict objectForKey:@"id"]
                 };
    }
    return dict;
}





@end
