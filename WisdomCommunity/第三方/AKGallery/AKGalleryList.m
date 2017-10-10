//
//  AKGalleryList.m
//  AKGallery
//
//  Created by ak on 16/11/8.
//  Copyright © 2016年 ak. All rights reserved.
//

#import "AKGalleryList.h"
#import "AKGallery.h"
#import "AKGalleryListCell.h"
#import "AKGalleryViewer.h"
NSString* identifier  = @"AKGalleryListCell";

@interface AKGalleryList ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation AKGalleryList
-(void)viewWillAppear:(BOOL)animated
{

    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
    }];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=self.gallery.custUI.listTitle;
    
    
    self.view.backgroundColor = BGColor;
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = [UIColor colorWithRed:74/255.0 green:135/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:topImageView];
    
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(5, 10, 25, 25);
    //    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 10,6, 90)];    //    returnBtn.backgroundColor = [UIColor cyanColor];
    [returnBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    //    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    

    //登录标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 44)];
    [navTitle setText:self.gallery.custUI.listTitle];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    

    
//    //back item
//    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
//    self.navigationItem.rightBarButtonItem=backItem;
    
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //todo:
    float width=[UIScreen mainScreen].bounds.size.width/3;
    layout.itemSize=CGSizeMake(width, width);
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    
    UICollectionView* cv= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.size.height) collectionViewLayout:layout];
    [self.view addSubview:cv];
    cv.dataSource=self;
    cv.delegate=self;
    cv.showsHorizontalScrollIndicator=NO;
    cv.backgroundColor=[UIColor whiteColor];
    self.collectionView = cv;
    [cv registerClass:[AKGalleryListCell class] forCellWithReuseIdentifier:identifier];

    
    
    
}
-(void)back{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.gallery.completion) {
            self.gallery.completion();
        }
    }];
}



-(AKGallery*)gallery{
   
    return (AKGallery*) self.navigationController;
    
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gallery.items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AKGalleryListCell* cell= [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    AKGalleryItem* item = [self.gallery itemForRow:indexPath.row];
    
    cell.model=item;
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //push viewer
//    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    self.gallery.selectIndex=indexPath.row;
    
    AKGalleryItem* item = [self.gallery itemForRow:indexPath.row];
//
    AKLog(@"didselect %@ row:%ld",item.title,(long)indexPath.row);
    
    AKGalleryViewerContainer* viewer =AKGalleryViewerContainer.new;
    
    [self.navigationController pushViewController:viewer animated:YES];
    
    
}

@end
