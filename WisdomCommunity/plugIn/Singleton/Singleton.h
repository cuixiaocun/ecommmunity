//
//  SingletonTeacher.h
//  eangluo
//
//  Created by 504-21 on 15/8/20.
//  Copyright (c) 2015年 504-21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

//物业缴费
@property (nonatomic,strong) NSMutableArray *selectProPayMonthArray;
//--------- - - - - -- - ---- ---- ---- ---- --- - --- -- - - - - --
//CYLRDataReuest 用
@property (nonatomic,strong) NSString *iploadImageUrl;//上传图片URL



//购物车
@property (nonatomic,assign) BOOL whetherBeginSelect;//是否开始选择商品
@property (nonatomic,strong) NSString *NowMerchantsId;//当前商家id
@property (nonatomic,strong) NSMutableArray *NowMerchsntsGArray;//当前商家总数据
@property (nonatomic,strong) NSMutableArray *SelectMerchantsGArray;//在每个商家选择的商品列表
@property (nonatomic,strong) NSMutableArray *SelectIdGArray;//在每个商家选择的商品id列表
@property (nonatomic,strong) NSMutableArray *RemoveArray;//已移除数组


//构造函数
+(Singleton *)getSingleton;

@end
