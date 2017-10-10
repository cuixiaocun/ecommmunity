//
//  MyComplantsTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyComplantsTableViewCell.h"

@implementation MyComplantsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString*)typeStr
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView *topBg =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, 74*CXCWidth)];
        [self addSubview:topBg];
        topBg.backgroundColor =BGColor;
        
        UILabel *timeLabel  = [[UILabel alloc] initWithFrame:CGRectMake(30*CXCWidth, 0, CYScreanW, 74*CXCWidth)];
        timeLabel.textColor = TextGroColor;
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.text = @"    时间";
        [self addSubview:timeLabel];
        self.timeLabel =timeLabel;
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        NSArray *leftArr =[[NSArray alloc]init];

        if([typeStr isEqualToString:@"报修"])
        {
            leftArr =@[@"报修状态",@"报修人",@"电话",@"楼宇号",@"",];

        
        }else
        {
        
            leftArr =@[@"投诉状态",@"投诉人",@"电话",@"投诉类型",@"",];

        }
        for (int i=0; i<4; i++) {
            UILabel *promptLabel = [[UILabel alloc] init];
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(300*CXCWidth,topBg.bottom+i*96*CXCWidth , 420*CXCWidth, 96*CXCWidth)];

            if (i==0) {
                //提示图标
                UIImageView *promptImage = [[UIImageView alloc] initWithFrame:CGRectMake(30*CXCWidth,topBg.bottom+25*CXCWidth, 32*CXCWidth,44*CXCWidth)];
//                promptImage.backgroundColor =[UIColor redColor];
                [self addSubview:promptImage];
                promptImage.image =[UIImage imageNamed:@"icon_wo_dingdan"];
                promptLabel.frame =CGRectMake(promptImage.right+20*CXCWidth, topBg.bottom, 300*CXCWidth, 96*CXCWidth);
                segmentationImmage.frame =CGRectMake(0, timeLabel.bottom+95*CXCWidth*(i+1), CYScreanW, 1*CXCWidth);
                promptLabel.textColor = TEXTColor;
                rightLabel.textColor = NavColor;


            }else
            {
                promptLabel.frame =CGRectMake(30*CXCWidth, topBg.bottom+i*96*CXCWidth, 300*CXCWidth, 96*CXCWidth);
                segmentationImmage.frame =CGRectMake(25*CXCWidth, timeLabel.bottom+ 95*CXCWidth*(i+1), CYScreanW, 1*CXCWidth);
                promptLabel.textColor = TEXTColor;

                rightLabel.textColor = TextGroColor;

            }
            //提示文字
            promptLabel.font = font;
            promptLabel.text =leftArr[i];
            [self addSubview:promptLabel];
            
            //内容（右边）
            rightLabel.tag =110+i;
            rightLabel.textAlignment =NSTextAlignmentRight;
            rightLabel.font = [UIFont fontWithName:@"Arial" size:14];
            [self addSubview:rightLabel];
            if (i==0) {
                self.resultLabel = rightLabel;
            }            //分割线
            segmentationImmage.backgroundColor = BGColor;
            [self addSubview:segmentationImmage];
        }
        
        //描述
        UILabel *MessageLabel = [[UILabel alloc] init];
        MessageLabel.textColor = TextGroColor;
        MessageLabel.font = font;
        MessageLabel.numberOfLines = 0;
        [MessageLabel sizeToFit];
        [self addSubview:MessageLabel];
        MessageLabel.frame =CGRectMake(30*CXCWidth, 480*CXCWidth,690*CXCWidth , 200*CXCWidth);
        self.promptLabel = MessageLabel;
         EGOImageButton* imgV =[[EGOImageButton   alloc]initWithFrame:CGRectMake(30*CXCWidth,MessageLabel.bottom+ 40*CXCWidth, 130*CXCWidth, 130*CXCWidth)];
        [imgV addTarget:self action:@selector(magnifyImage) forControlEvents:UIControlEventTouchUpInside];
        
//        imgV.backgroundColor =[UIColor redColor];
        [self addSubview:imgV];
        imgV.tag =222;

        self.imgV =imgV;

     }
    return self;
}
- (void) setModel:(MyComplaintsModel *)model
{
    _model = model;
    NSLog(@"_model.promptString = %@,_model.resultString = %@",_model.promptString,_model.resultString);
    //内容
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;//对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineSpacing = 0.0f;//行间距
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_model.promptString attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    self.promptLabel.attributedText = attrText;
    self.resultLabel.text = [NSString stringWithFormat:@"%@",_model.resultString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
    CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:_model.promptString.length > 0 ? _model.promptString : @"未获取"]];
    self.promptLabel.height=layout.textBoundingSize.height;
    EGOImageView*img =[self viewWithTag:222];
    _imgV =img ;
    if(IsNilString(_model.promptImageString))
    {
        img.hidden =YES;
    
    }else
    {
        img.hidden =NO;

        NSString *str =[NSString stringWithFormat: @"%@",_model.promptImageString];
        
          img.frame =CGRectMake(30*CXCWidth,_promptLabel.bottom+ 40*CXCWidth, 130*CXCWidth, 130*CXCWidth);

        _imgV.imageURL=[NSURL URLWithString:[NSString stringWithFormat: @"%@",_model.promptImageString]];


//        _imgV.image =[UIImage imageWithData:[NSData  dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",_model.promptImageString]]]];
    }
    UILabel *nameL =[self viewWithTag:111];
    UILabel *phoneL =[self viewWithTag:112];
    UILabel *addL =[self viewWithTag:113];
    nameL.text =_model.nameString;
    phoneL.text =_model.phoneString;
    
    
    if ([strType isEqualToString:@"报修"]) {
        addL.text =_model.addString;

    }else
    {
        
        if ([_model.category isEqualToString:@"1"]) {
            addL.text =@"房屋设施";
        }else  if ([_model.category isEqualToString:@"2"]) {
            addL.text =@"公共设施";
        }else if ([_model.category isEqualToString:@"3"]) {
            addL.text =@"服务评价";
        }

    
    }
}


-(void)magnifyImage

{
    
    [self.delegate showBigPhoto:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imgV.imageURL]]];
    
 
    
}
+(void)showImage:(UIImageView *)avatarImageView{
    

    UIImage *image=avatarImageView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.image=image;
    
    imageView.tag=1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake(0,0,
                                CYScreanW, CXCScreanH);
        
        backgroundView.alpha=1;
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}
+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=oldframe;
        
        backgroundView.alpha=0;
        
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
        
    }];
}

@end
