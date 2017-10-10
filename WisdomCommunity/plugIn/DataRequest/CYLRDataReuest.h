//
//  CYLRDataReuest.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYLRDataReuest : NSObject
+ (NSString *) uploadImage:(UIImage *)image;
//上传图片
+ (NSString *) uploadImage:(UIImage *)image withView:(UIView *)view;
@end
