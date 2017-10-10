//
//  PList.m
//
//  Created by   on 17/1/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "PList.h"


NSString *const kPListId = @"id";
NSString *const kPListIntro = @"intro";
NSString *const kPListGmtCreate = @"gmtCreate";
NSString *const kPListImg = @"img";
NSString *const kPListPrice = @"price";
NSString *const kPListSuccessnum = @"successnum";
NSString *const kPListGmtModify = @"gmtModify";
NSString *const kPListOrder = @"order";
NSString *const kPListShopId = @"shopId";
NSString *const kPListAvailable = @"available";
NSString *const kPListScore = @"score";
NSString *const kPListName = @"name";
NSString *const kPListCategoryId = @"categoryId";


@interface PList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PList

@synthesize pListIdentifier = _pListIdentifier;
@synthesize intro = _intro;
@synthesize gmtCreate = _gmtCreate;
@synthesize img = _img;
@synthesize price = _price;
@synthesize successnum = _successnum;
@synthesize gmtModify = _gmtModify;
@synthesize order = _order;
@synthesize shopId = _shopId;
@synthesize available = _available;
@synthesize score = _score;
@synthesize name = _name;
@synthesize categoryId = _categoryId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.pListIdentifier = [[self objectOrNilForKey:kPListId fromDictionary:dict] doubleValue];
            self.intro = [self objectOrNilForKey:kPListIntro fromDictionary:dict];
            self.gmtCreate = [self objectOrNilForKey:kPListGmtCreate fromDictionary:dict];
            self.img = [self objectOrNilForKey:kPListImg fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kPListPrice fromDictionary:dict] doubleValue];
            self.successnum = [[self objectOrNilForKey:kPListSuccessnum fromDictionary:dict] doubleValue];
            self.gmtModify = [self objectOrNilForKey:kPListGmtModify fromDictionary:dict];
            self.order = [[self objectOrNilForKey:kPListOrder fromDictionary:dict] doubleValue];
            self.shopId = [self objectOrNilForKey:kPListShopId fromDictionary:dict];
            self.available = [self objectOrNilForKey:kPListAvailable fromDictionary:dict];
            self.score = [self objectOrNilForKey:kPListScore fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPListName fromDictionary:dict];
            self.categoryId = [self objectOrNilForKey:kPListCategoryId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pListIdentifier] forKey:kPListId];
    [mutableDict setValue:self.intro forKey:kPListIntro];
    [mutableDict setValue:self.gmtCreate forKey:kPListGmtCreate];
    [mutableDict setValue:self.img forKey:kPListImg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kPListPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.successnum] forKey:kPListSuccessnum];
    [mutableDict setValue:self.gmtModify forKey:kPListGmtModify];
    [mutableDict setValue:[NSNumber numberWithDouble:self.order] forKey:kPListOrder];
    [mutableDict setValue:self.shopId forKey:kPListShopId];
    [mutableDict setValue:self.available forKey:kPListAvailable];
    [mutableDict setValue:self.score forKey:kPListScore];
    [mutableDict setValue:self.name forKey:kPListName];
    [mutableDict setValue:self.categoryId forKey:kPListCategoryId];

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

    self.pListIdentifier = [aDecoder decodeDoubleForKey:kPListId];
    self.intro = [aDecoder decodeObjectForKey:kPListIntro];
    self.gmtCreate = [aDecoder decodeObjectForKey:kPListGmtCreate];
    self.img = [aDecoder decodeObjectForKey:kPListImg];
    self.price = [aDecoder decodeDoubleForKey:kPListPrice];
    self.successnum = [aDecoder decodeDoubleForKey:kPListSuccessnum];
    self.gmtModify = [aDecoder decodeObjectForKey:kPListGmtModify];
    self.order = [aDecoder decodeDoubleForKey:kPListOrder];
    self.shopId = [aDecoder decodeObjectForKey:kPListShopId];
    self.available = [aDecoder decodeObjectForKey:kPListAvailable];
    self.score = [aDecoder decodeObjectForKey:kPListScore];
    self.name = [aDecoder decodeObjectForKey:kPListName];
    self.categoryId = [aDecoder decodeObjectForKey:kPListCategoryId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_pListIdentifier forKey:kPListId];
    [aCoder encodeObject:_intro forKey:kPListIntro];
    [aCoder encodeObject:_gmtCreate forKey:kPListGmtCreate];
    [aCoder encodeObject:_img forKey:kPListImg];
    [aCoder encodeDouble:_price forKey:kPListPrice];
    [aCoder encodeDouble:_successnum forKey:kPListSuccessnum];
    [aCoder encodeObject:_gmtModify forKey:kPListGmtModify];
    [aCoder encodeDouble:_order forKey:kPListOrder];
    [aCoder encodeObject:_shopId forKey:kPListShopId];
    [aCoder encodeObject:_available forKey:kPListAvailable];
    [aCoder encodeObject:_score forKey:kPListScore];
    [aCoder encodeObject:_name forKey:kPListName];
    [aCoder encodeObject:_categoryId forKey:kPListCategoryId];
}

- (id)copyWithZone:(NSZone *)zone {
    PList *copy = [[PList alloc] init];
    
    
    
    if (copy) {

        copy.pListIdentifier = self.pListIdentifier;
        copy.intro = [self.intro copyWithZone:zone];
        copy.gmtCreate = [self.gmtCreate copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.price = self.price;
        copy.successnum = self.successnum;
        copy.gmtModify = [self.gmtModify copyWithZone:zone];
        copy.order = self.order;
        copy.shopId = [self.shopId copyWithZone:zone];
        copy.available = [self.available copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.categoryId = [self.categoryId copyWithZone:zone];
    }
    
    return copy;
}


@end
