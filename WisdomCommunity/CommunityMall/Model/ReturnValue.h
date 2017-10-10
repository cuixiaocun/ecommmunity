//
//  ReturnValue.h
//
//  Created by   on 17/1/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ReturnValue : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSArray *pList;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, assign) double returnValueIdentifier;
@property (nonatomic, assign) double order;
@property (nonatomic, assign) id gmtModify;
@property (nonatomic, assign) double procountNum;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
