//
//  CZExhibitionModel.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZExhibitionModel : NSObject

@property ( nonatomic, copy)NSString *imageUrl;
@property ( nonatomic, copy)NSString *name;
@property ( nonatomic, copy)NSString *account;
@property ( nonatomic, copy)NSString *date;
@property ( nonatomic, copy)NSString *modelID;
@property ( nonatomic, copy)NSString *state;
@property ( nonatomic, copy)NSString *type;//0:油画 1:装饰
@property ( nonatomic, copy)NSString *flag;//1:app 2:官方
@property ( nonatomic, copy)NSString *content;//html内容
@end
