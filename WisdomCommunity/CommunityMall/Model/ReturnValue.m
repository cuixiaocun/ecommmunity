//
//  ReturnValue.m
//
//  Created by   on 17/1/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ReturnValue.h"
#import "PList.h"


NSString *const kReturnValueShopId = @"shopId";
NSString *const kReturnValuePList = @"pList";
NSString *const kReturnValueGmtCreate = @"gmtCreate";
NSString *const kReturnValueId = @"id";
NSString *const kReturnValueOrder = @"order";
NSString *const kReturnValueGmtModify = @"gmtModify";
NSString *const kReturnValueProcountNum = @"procountNum";
NSString *const kReturnValueName = @"name";


@interface ReturnValue ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ReturnValue

@synthesize shopId = _shopId;
@synthesize pList = _pList;
@synthesize gmtCreate = _gmtCreate;
@synthesize returnValueIdentifier = _returnValueIdentifier;
@synthesize order = _order;
@synthesize gmtModify = _gmtModify;
@synthesize procountNum = _procountNum;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.shopId = [self objectOrNilForKey:kReturnValueShopId fromDictionary:dict];
    NSObject *receivedPList = [dict objectForKey:kReturnValuePList];
    NSMutableArray *parsedPList = [NSMutableArray array];
    
    if ([receivedPList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPList addObject:[PList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPList isKindOfClass:[NSDictionary class]]) {
       [parsedPList addObject:[PList modelObjectWithDictionary:(NSDictionary *)receivedPList]];
    }

    self.pList = [NSArray arrayWithArray:parsedPList];
            self.gmtCreate = [self objectOrNilForKey:kReturnValueGmtCreate fromDictionary:dict];
            self.returnValueIdentifier = [[self objectOrNilForKey:kReturnValueId fromDictionary:dict] doubleValue];
            self.order = [[self objectOrNilForKey:kReturnValueOrder fromDictionary:dict] doubleValue];
            self.gmtModify = [self objectOrNilForKey:kReturnValueGmtModify fromDictionary:dict];
            self.procountNum = [[self objectOrNilForKey:kReturnValueProcountNum fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kReturnValueName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shopId forKey:kReturnValueShopId];
    NSMutableArray *tempArrayForPList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.pList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPList] forKey:kReturnValuePList];
    [mutableDict setValue:self.gmtCreate forKey:kReturnValueGmtCreate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.returnValueIdentifier] forKey:kReturnValueId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.order] forKey:kReturnValueOrder];
    [mutableDict setValue:self.gmtModify forKey:kReturnValueGmtModify];
    [mutableDict setValue:[NSNumber numberWithDouble:self.procountNum] forKey:kReturnValueProcountNum];
    [mutableDict setValue:self.name forKey:kReturnValueName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.shopId = [aDecoder decodeObjectForKey:kReturnValueShopId];
    self.pList = [aDecoder decodeObjectForKey:kReturnValuePList];
    self.gmtCreate = [aDecoder decodeObjectForKey:kReturnValueGmtCreate];
    self.returnValueIdentifier = [aDecoder decodeDoubleForKey:kReturnValueId];
    self.order = [aDecoder decodeDoubleForKey:kReturnValueOrder];
    self.gmtModify = [aDecoder decodeObjectForKey:kReturnValueGmtModify];
    self.procountNum = [aDecoder decodeDoubleForKey:kReturnValueProcountNum];
    self.name = [aDecoder decodeObjectForKey:kReturnValueName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_shopId forKey:kReturnValueShopId];
    [aCoder encodeObject:_pList forKey:kReturnValuePList];
    [aCoder encodeObject:_gmtCreate forKey:kReturnValueGmtCreate];
    [aCoder encodeDouble:_returnValueIdentifier forKey:kReturnValueId];
    [aCoder encodeDouble:_order forKey:kReturnValueOrder];
    [aCoder encodeObject:_gmtModify forKey:kReturnValueGmtModify];
    [aCoder encodeDouble:_procountNum forKey:kReturnValueProcountNum];
    [aCoder encodeObject:_name forKey:kReturnValueName];
}

- (id)copyWithZone:(NSZone *)zone {
    ReturnValue *copy = [[ReturnValue alloc] init];
    
    
    
    if (copy) {

        copy.shopId = [self.shopId copyWithZone:zone];
        copy.pList = [self.pList copyWithZone:zone];
        copy.gmtCreate = [self.gmtCreate copyWithZone:zone];
        copy.returnValueIdentifier = self.returnValueIdentifier;
        copy.order = self.order;
        copy.gmtModify = [self.gmtModify copyWithZone:zone];
        copy.procountNum = self.procountNum;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
