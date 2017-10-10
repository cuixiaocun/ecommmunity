//
//  UIScrollView+Myscrollview.m
//  Demo_simple
//
//  Created by Developer on 15/8/13.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "UIScrollView+Myscrollview.h"

@implementation UIScrollView (Myscrollview)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];

}
@end
