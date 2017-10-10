//
//  comBBSTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "comBBSTableViewCell.h"

@implementation comBBSTableViewCell
{
    
    UIView * bottomView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(25*CXCWidth, 29*CXCWidth, CXCWidth*80, CXCWidth*80)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImage = headImage;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        nameLabel.frame =CGRectMake(8*CXCWidth+headImage.right, 29*CXCWidth, 500*CXCWidth, 80*CXCWidth);
        self.nameLabel = nameLabel;
        
        //论坛内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.00];
        contentLabel.font =[UIFont systemFontOfSize:14];

        [self.contentView addSubview:contentLabel];
        contentLabel.frame =CGRectMake(20*CXCWidth, headImage.bottom+26*CXCWidth, 710*CXCWidth, 60*CXCWidth);
        self.contentLabel = contentLabel;
        //展示内容图片
        UIImageView *contentImageOne = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageOne];
        contentImageOne.frame =CGRectMake(20*CXCWidth, contentLabel.bottom+26*CXCWidth, 204*CXCWidth, 204*CXCWidth);
        
        //        [contentImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
        //            make.top.equalTo(contentLabel.mas_bottom).offset(0);
        //            make.height.mas_equalTo(204*CXCWidth);
        //            make.width.mas_equalTo(204*CXCWidth);
        //        }];
        self.contentImageOne = contentImageOne;
        self.contentImageOne.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageOne.clipsToBounds = YES;
        
        UIImageView *contentImageTwo = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageTwo];
        contentImageTwo.frame =CGRectMake((20+13+204)*CXCWidth, contentLabel.bottom+26*CXCWidth, 204*CXCWidth, 204*CXCWidth);
        
        //        [contentImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(contentImageOne.mas_right).offset(13*CXCWidth);
        //            make.top.and.width.and.height.equalTo(contentImageOne);
        //        }];
        self.contentImageTwo = contentImageTwo;
        self.contentImageTwo.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageTwo.clipsToBounds = YES;
        
        UIImageView *contentImageThree = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageThree];
        contentImageThree.frame =CGRectMake((20+13+204+13+204)*CXCWidth, contentLabel.bottom+26*CXCWidth, 204*CXCWidth, 204*CXCWidth);
        
        //        [contentImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(contentImageTwo.mas_right).offset(13*CXCWidth);
        //            make.top.and.width.and.height.equalTo(contentImageOne);
        //        }];
        self.contentImageThree = contentImageThree;
        self.contentImageThree.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageThree.clipsToBounds = YES;
        
        //提示图片总数
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor whiteColor];
        [contentImageThree addSubview:promptLabel];
        promptLabel.frame =CGRectMake(160*CXCWidth, 160*CXCWidth, 44*CXCWidth, 44*CXCWidth);
        //        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(self.contentImageThree);
        //            make.bottom.equalTo(contentImageOne.mas_bottom);
        //            make.height.mas_equalTo(44*CXCWidth);
        //            make.width.mas_equalTo(44*CXCWidth);
        //        }];
        self.promptLabel = promptLabel;
        promptLabel.textAlignment =NSTextAlignmentCenter;
        
        UIImageView *promptImage = [[UIImageView alloc] init];
        promptImage.image = [UIImage imageNamed:@"icon_pic"];
        [contentImageThree addSubview:promptImage];
        promptImage.frame =CGRectMake(120*CXCWidth, 160*CXCWidth, 44*CXCWidth, 44*CXCWidth);
        
        
        //        [promptImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(promptLabel.mas_left).offset(-5);
        //            make.bottom.equalTo(contentImageOne.mas_bottom).offset(-(CYScreanH - 64) * 0.015);
        //            make.height.mas_equalTo((CYScreanH - 64) * 0.03);
        //            make.width.mas_equalTo(CYScreanW * 0.06);
        //        }];
        self.promptImage = promptImage;
        //        UIImageView *xianImg =[[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth,136*CXCWidth, 740*CXCWidth, 1*CXCWidth)];
        //        [self.contentView addSubview:xianImg];
        //        xianImg.backgroundColor =BGColor;
        
        
        //下边
        bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, contentImageThree.bottom, CYScreanW, 78*CXCWidth*2)];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor =[UIColor whiteColor];
        
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00];
        timeLabel.font = [UIFont systemFontOfSize:13];
        [bottomView addSubview:timeLabel];
        
        timeLabel.frame =CGRectMake(20*CXCWidth, 0, 280*CXCWidth, 77*CXCWidth);
        self.timeLabel = timeLabel;
        //来自
        UILabel *comeLabel = [[UILabel alloc] init];
        comeLabel.textColor = [UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00];
        comeLabel.textAlignment = NSTextAlignmentRight;
        comeLabel.font = [UIFont systemFontOfSize:13];
        [bottomView addSubview:comeLabel];
        comeLabel.frame =CGRectMake(250*CXCWidth,0, 400*CXCWidth, 77*CXCWidth);
        self.comeLabel = comeLabel;
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(comeLabel.right-170*CXCWidth, comeLabel.top+24*CXCWidth, 25*CXCWidth,30*CXCWidth )];
        [bottomView addSubview:image];
        [image setImage:[UIImage imageNamed:@"icon_location"]];
        
        
        
        //细线
        UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, comeLabel.bottom, CYScreanW, 1*CXCWidth)];
        [bottomView addSubview:img];
        [img setBackgroundColor:BGColor];
        
        
        //查看次数
        UIButton *toViewButton = [[UIButton alloc] init];
        toViewButton.titleLabel.font = font;
        [toViewButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        //        [toViewButton setImage:[UIImage imageNamed:@"icon_read"] forState:UIControlStateNormal];
        //        toViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        //        toViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [bottomView addSubview:toViewButton];
        self.toViewButton = toViewButton;
        toViewButton.frame =CGRectMake(91*CXCWidth,img.bottom+ 23*CXCWidth , 110*CXCWidth,35*CXCWidth);
        UIImageView *imgOne=[[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5*CXCWidth, 35*CXCWidth, 20*CXCWidth)];
        [imgOne setImage:[UIImage imageNamed:@"icon_read"]];
        [_toViewButton addSubview:imgOne];
        UILabel *sLableOne =[[UILabel alloc]initWithFrame:CGRectMake(imgOne.right+10*CXCWidth,0 ,100,35*CXCWidth )];
        sLableOne.textColor =[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00];
        sLableOne.text=@"123";
        sLableOne.tag=111;
        sLableOne.font =[UIFont systemFontOfSize:13];
        [_toViewButton addSubview:sLableOne];
        
        
        
        
        
        
        
        //点赞
        UIButton *thumbUpButton = [[UIButton alloc] init];
        thumbUpButton.titleLabel.font = font;
        [thumbUpButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        //        [thumbUpButton setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        //        thumbUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        //        thumbUpButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [bottomView addSubview:thumbUpButton];
        thumbUpButton.frame =CGRectMake(550*CXCWidth,img.bottom+ 23*CXCWidth , 110*CXCWidth,35*CXCWidth);
        self.thumbUpButton = thumbUpButton;
        
        
        UIImageView *img3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5*CXCWidth, 30*CXCWidth, 30*CXCWidth)];
        [img3 setImage:[UIImage imageNamed:@"icon_like"]];
        [_thumbUpButton addSubview:img3];
        UILabel *sLable3 =[[UILabel alloc]initWithFrame:CGRectMake(img3.right+10*CXCWidth,0 ,100,35*CXCWidth )];
        sLable3.textColor =[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00];
        
        sLable3.text=@"123";
        sLable3.tag=112;
        
        sLable3.font =[UIFont systemFontOfSize:13];
        [_thumbUpButton addSubview:sLable3];
        
        
        //评论
        UIButton *commentButton = [[UIButton alloc] init];//comments_icon
        commentButton.titleLabel.font = font;
        [commentButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        //        [commentButton setImage:[UIImage imageNamed:@"icon_pinglun"] forState:UIControlStateNormal];
        //        commentButton.imageEdgeInsets = UIEdgeInsetsMake(-3, 0, -3, 3);
        //        commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [bottomView addSubview:commentButton];
        commentButton.frame =CGRectMake(320*CXCWidth,img.bottom+ 23*CXCWidth , 110*CXCWidth,35*CXCWidth);
        self.commentButton = commentButton;
        UIImageView *imgTwo=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5*CXCWidth, 30*CXCWidth, 30*CXCWidth)];
        [imgTwo setImage:[UIImage imageNamed:@"icon_pinglun"]];
        [_commentButton addSubview:imgTwo];
        UILabel *sLableTwo =[[UILabel alloc]initWithFrame:CGRectMake(imgTwo.right+10*CXCWidth,0 ,100,35*CXCWidth )];
        sLableTwo.textColor =[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00];
        sLableTwo.text=@"123";
        sLableTwo.tag=113;
        sLableTwo.font =[UIFont systemFontOfSize:13];
        [_commentButton addSubview:sLableTwo];
        
        
        
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
        
        
    }
    return self;
}
- (void) setModel:(comBBSModel *)model
{
    _model = model;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[CYSmallTools isValidUrl:self.model.headImageString] ? self.model.headImageString : DefaultHeadImage] placeholderImage:nil];
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.model.nameString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.model.timeString];
    self.comeLabel.text = [NSString stringWithFormat:@"%@",self.model.comeString];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",self.model.contentString];
    if ([self.model.pictureNumber integerValue] > 2)
    {
        self.promptImage.hidden = NO;
    }
    else
        self.promptImage.hidden = YES;
    
    self.promptLabel.text = [NSString stringWithFormat:@"%@",self.model.pictureNumber];
    UILabel *labelOne =[self viewWithTag:111];
    UILabel *labelTwo =[self viewWithTag:113];
    UILabel *labelThree =[self viewWithTag:112];
    labelOne.text =[NSString stringWithFormat:@"%@",self.model.checkNumber];
    labelTwo.text=[NSString stringWithFormat:@"%@",self.model.commentNumber];
    labelThree.text =[NSString stringWithFormat:@"%@",self.model.fabulousNumber];
    
    

//    
//    [self.toViewButton setTitle:[NSString stringWithFormat:@"%@",self.model.checkNumber] forState:UIControlStateNormal];
//    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",self.model.commentNumber] forState:UIControlStateNormal];
//    [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",self.model.fabulousNumber] forState:UIControlStateNormal];
    NSLog(@"%@",self.model.contentImageOne);
    if([self.model.contentImageOne isEqual:[NSNull null]]||[self.model.contentImageOne isEqualToString:@"<null>"])
    {
        
        bottomView.frame =CGRectMake(0, self.contentLabel.bottom, CYScreanW, 78*2*CXCWidth);
        //        bottomView.backgroundColor =[UIColor yellowColor];
        NSLog(@"1111%f", bottomView.frame.size.height);
        
    }else
    {
        //        bottomView.backgroundColor =[UIColor blueColor];
        bottomView.frame =CGRectMake(0, self.contentLabel.bottom+26*CXCWidth+204*CXCWidth, CYScreanW, 78*2*CXCWidth);

        NSLog(@"2222%f", bottomView.frame.size.height);

        
    }
    
    

    if ([UIScreen mainScreen].bounds.size.height == 480)
    {
    [self.contentImageOne setImage:[self imageCompressWithSimple:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.contentImageOne ]]]] scale:CGSizeMake((CYScreanW * 0.06)*5, ((CYScreanH - 64) * 0.03*5))]];
    [self.contentImageTwo setImage:[self imageCompressWithSimple:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.contentImageTwo ]]]] scale:CGSizeMake((CYScreanW * 0.06)*5, ((CYScreanH - 64) * 0.03)*5)]];
    [self.contentImageThree setImage:[self imageCompressWithSimple:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.contentImageThree ]]]] scale:CGSizeMake((CYScreanW * 0.06)*5 ,((CYScreanH - 64) * 0.03)*5)]];

    }else
    {
        [self.contentImageOne sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageOne] placeholderImage:nil];
        [self.contentImageTwo sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageTwo] placeholderImage:nil];
        [self.contentImageThree sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageThree] placeholderImage:nil];
        

    
    }
    
    

    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:self.comeLabel.text];
//    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,2)];
    //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
    self.comeLabel.attributedText = sendMessageString;
    
}
- (UIImage*)imageCompressWithSimple:(UIImage*)sourceImage scale:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
