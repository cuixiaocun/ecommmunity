//
//  PList.h
//
//  Created by   on 17/1/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double pListIdentifier;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double successnum;
@property (nonatomic, assign) id gmtModify;
@property (nonatomic, assign) double order;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *available;
@property (nonatomic, assign) id score;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *categoryId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
