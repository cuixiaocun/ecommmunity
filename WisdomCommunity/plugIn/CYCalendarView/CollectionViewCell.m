//
//  CollectionViewCell.m
//  collectionview
//
//  Created by HB on 16/1/5.
//  Copyright © 2016年 HB. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
//        _topImage.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:_topImage];
        //背景图片
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CYScreanW / 10 - self.frame.size.height) / 2, 0, self.frame.size.height, self.frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:@"icon_posting_bg"];
        [self.contentView addSubview:self.backImageView];
        //阳历
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CYScreanW / 10, self.frame.size.height)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.font = [UIFont systemFontOfSize:20];
        _botlabel.backgroundColor = [UIColor clearColor];
        _botlabel.textColor = [UIColor colorWithRed:0.514 green:0.541 blue:0.541 alpha:1.00];
        [self.contentView addSubview:_botlabel];
        //阴历
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, CYScreanW / 10, self.frame.size.height)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:10];
        _dayLabel.backgroundColor = [UIColor clearColor];
        _dayLabel.textColor = [UIColor colorWithRed:0.514 green:0.541 blue:0.541 alpha:1.00];
        [self.contentView addSubview:_dayLabel];
        
        
        
    }
    return self;
}


@end
