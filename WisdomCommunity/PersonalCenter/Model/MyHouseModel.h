//
//  MyHouseModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHouseModel : NSObject



@property (nonatomic,strong) NSString *address;//
@property (nonatomic,strong) NSString *comNo;//小区id
@property (nonatomic,strong) NSString *prompt;//

+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
