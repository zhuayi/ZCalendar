//
//  ZCalendarScroolView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarCollectionView.h"
#import "ZCalendarDrawViewCell.h"
@implementation ZCalendarCollectionView
{
    NSMutableArray *calendarDrawViewArray;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
    
        self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
        
        //注册Cell，必须要有
        [self registerClass:[ZCalendarDrawViewCell class] forCellWithReuseIdentifier:@"ZCalendarDrawViewCell"];
    }
    return self;
}

- (void)setPageCount:(int)pageCount
{
    _pageCount = pageCount;
    
    self.contentSize = CGSizeMake(self.frame.size.width * _pageCount, self.frame.size.height);
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12 * 10;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"ZCalendarDrawViewCell";
    ZCalendarDrawViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setDate:2015 month:4];
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



@end
