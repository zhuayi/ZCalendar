//
//  ZCalendarScroolView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarCollectionView.h"
#import "ZCalendarDrawViewCell.h"
#import "ZCalendarDate.h"
@implementation ZCalendarCollectionView
{
    NSMutableArray *_dateArray;
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
        
        _dateArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData {
    _starYear = starDate;
    _endYear = endData;
    
    NSDateComponents *today = [ZCalendarDate getDateComponentsByDate:[NSDate date]];
    NSInteger current = 0;
    NSInteger intervalMonth = (endData - starDate) + 1;
    
    for (int i = 0 ; i < intervalMonth; i++) {
        
        for (int j = 1; j <= 12; j++) {
            
            NSDate *date = [[ZCalendarDate getFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%d-1", starDate + i, j]];
            [_dateArray addObject:date];
            
            // 如果是当月,则记录下来,稍后要滚动到这里
            if ((starDate + i) == [today year] && j == [today month]) {
                current = i * 12 + j - 1;
            }
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self setContentOffset:CGPointMake(0, current* self.frame.size.height) animated:YES];
    });
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dateArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ZCalendarDrawViewCell";
    ZCalendarDrawViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setDate:_dateArray[indexPath.row]];
    
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
