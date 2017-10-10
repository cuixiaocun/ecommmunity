//
//  ComMallCollectionViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallCollectionViewCell.h"

@implementation ComMallCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.09 - CYScreanW * 0.12, CYScreanW * 0.12, CYScreanW * 0.12)];
        self.topMCImage.backgroundColor = [UIColor whiteColor];
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake( -CYScreanW * 0.05, (CYScreanH - 64) * 0.09, CYScreanW * 0.22, (CYScreanH - 64) * 0.06)];
        self.promtpmcLabel.textColor = [UIColor blackColor];
        self.promtpmcLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.promtpmcLabel];
    }
    return self;
}

@end
