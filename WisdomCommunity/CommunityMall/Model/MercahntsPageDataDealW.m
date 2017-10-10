//
//  MercahntsPageDataDealW.m
//  WisdomCommunity
//
//  Created by bridge on 17/1/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MercahntsPageDataDealW.h"

@implementation MercahntsPageDataDealW


//评论数据
+ (NSArray *) initCommentModel:(NSArray *)array
{
    NSMutableArray *commentArray = [[NSMutableArray alloc] init];
    NSMutableArray *heigthArray = [[NSMutableArray alloc] init];
    for (NSInteger i = array.count - 1; i >= 0; i --)
    {
        NSDictionary *commentDict = [NSDictionary dictionaryWithDictionary:array[i]];//评论信息
        NSString *accountDoString = [NSString stringWithFormat:@"%@",[commentDict objectForKey:@"accountDO"]];
        NSDictionary *dict;
        NSString *commentContent = [NSString stringWithFormat:@"%@",[commentDict objectForKey:@"evaluate"]];
        NSString *commentStart = [NSString stringWithFormat:@"%.1f",([[commentDict objectForKey:@"productStar"] floatValue] + [[commentDict objectForKey:@"serveStar"] floatValue]) / 2];
        if (accountDoString.length > 6)
        {
            NSDictionary *accountDict = [NSDictionary dictionaryWithDictionary:[commentDict objectForKey:@"accountDO"]];//
            //评论数据
            dict = @{
                     @"headString":[NSString stringWithFormat:@"%@",[accountDict objectForKey:@"imgAddress"]],
                     @"nameString":[NSString stringWithFormat:@"%@",[accountDict objectForKey:@"nickName"]],
                     @"startString":[NSString stringWithFormat:@"%@",commentStart],
                     @"timeString":[NSString stringWithFormat:@"%@",[commentDict objectForKey:@"gmtCreate"]],
                     @"contentString":commentContent
                     };
        }
        else
        {
            //评论数据
            dict = @{
                     @"headString":DefaultHeadImage,
                     @"nameString":@"未获取",
                     @"startString":[NSString stringWithFormat:@"%@",commentStart],
                     @"timeString":[NSString stringWithFormat:@"%@",[commentDict objectForKey:@"gmtCreate"]],
                     @"contentString":commentContent
                     };
        }
        //记录评论高度
        CGSize sizeP = CGSizeMake(CYScreanW * 0.7, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:commentContent.length > 0 ? commentContent : @"未获取"]];
        [heigthArray addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
        MerchantsCommentModel *model = [MerchantsCommentModel bodyWithDict:dict];
        [commentArray addObject:model];
    }
    
    return @[commentArray,heigthArray];
}
//产品数据
+ (NSArray *) initMerchantsModel:(NSArray *)array
{
    Singleton *goodsSing = [Singleton getSingleton];
    //初始化数据
    NSMutableArray *GoodsTypeArray = [[NSMutableArray alloc] init];
    NSMutableArray *GoodsPlistModelArray = [[NSMutableArray alloc] init];
    
    //制作模型
    for (NSInteger i = 0; i < array.count; i ++)
    {
        //产品分类
        NSDictionary *typeDict = [NSDictionary dictionaryWithDictionary:array[i]];//获取分类数据
        NSDictionary *dicte = @{@"promptString":[NSString stringWithFormat:@"%@",[typeDict objectForKey:@"name"]],@"selectGoodsNumber":@"0",@"currentSectionNumber":[NSString stringWithFormat:@"%ld",i]};
        GoodsTypeModel *model2 = [GoodsTypeModel bodyWithDict:dicte];
        [GoodsTypeArray addObject:model2];
        
        //产品
        NSArray *goodsArray = [NSArray arrayWithArray:[typeDict objectForKey:@"pList"]];//商品列表
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        for (NSDictionary *goodsDict in goodsArray)
        {
            [goodsSing.NowMerchsntsGArray addObject:goodsDict];//将总的商家产品数据添加到商品总数中
            NSDictionary *dict = @{
                                   @"currentSection":[NSString stringWithFormat:@"%ld",i],
                                   @"numberString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"successnum"]],
                                   @"goodsImage":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"img"]],
                                   @"nameString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"name"]],
                                   @"contentString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"intro"]],
                                   @"moneyString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"price"]],
                                   @"goodsId":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"id"]]
                                   };
            MerchantsModel *model = [MerchantsModel bodyWithDict:dict];
            [array2 addObject:model];
        }
        [GoodsPlistModelArray addObject:array2];
    }
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    //添加底部空白
    NSDictionary *dict = @{
                           @"currentSection":[NSString stringWithFormat:@"%ld",array.count],
                           @"numberString":@"",
                           @"goodsImage":@"",
                           @"nameString":@"",
                           @"contentString":@"",
                           @"moneyString":@"",
                           @"goodsId":@""
                           };
    MerchantsModel *model = [MerchantsModel bodyWithDict:dict];
//    [array2 addObject:model];
    [GoodsPlistModelArray addObject:array2];
    
    NSDictionary *dicte = @{@"promptString":@"",@"selectGoodsNumber":@"",@"currentSectionNumber":[NSString stringWithFormat:@"%ld",array.count]};
    GoodsTypeModel *model2 = [GoodsTypeModel bodyWithDict:dicte];
    [GoodsTypeArray addObject:model2];
    NSLog(@"self.goodsSing.NowMerchsntsGArray.count = %ld",goodsSing.NowMerchsntsGArray.count);
    
    return @[GoodsTypeArray,GoodsPlistModelArray];
}

@end
