//
//  RootCollectionViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootCollectionViewCell.h"

@implementation RootCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (CYScreanH - 64) * 0.01, CYScreanW * 0.34 / 3, (CYScreanH - 64) * 0.075)];
        self.topImage.backgroundColor = [UIColor whiteColor];
        self.topImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_topImage];
        self.promtpLabel = [[UILabel alloc] initWithFrame:CGRectMake(-CYScreanW * 0.06, (CYScreanH - 64) * 0.085, CYScreanW * 0.34 / 3 + CYScreanW * 0.12, (CYScreanH - 64) * 0.045)];
        self.promtpLabel.textColor = [UIColor blackColor];
        self.promtpLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.promtpLabel];
    }
    return self;
}
@end
