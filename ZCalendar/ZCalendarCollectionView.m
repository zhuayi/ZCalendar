//
//  ZCalendarScroolView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarCollectionView.h"
#import "ZCalendarDate.h"
#import "ZCalendarYearHeardView.h"
@implementation ZCalendarCollectionView {
    NSMutableArray *_dateArray;
    NSInteger _intervalMonth;
    NSInteger _columnCount;
    BOOL asd;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout.minimumLineSpacing = 5;
    _layout.minimumInteritemSpacing = 0;
    _layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 50);
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        //注册Cell，必须要有
        [self registerClass:[ZCalendarDrawViewCell class] forCellWithReuseIdentifier:@"ZCalendarDrawViewCell"];
        
        [self registerClass:[ZCalendarYearHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        _dateArray = [NSMutableArray arrayWithCapacity:0];
        
        self.cellSize = self.frame.size;
    }
    return self;
}

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData {
    _starYear = starDate;
    _endYear = endData;
    
    NSDateComponents *today = [ZCalendarDate getDateComponentsByDate:[NSDate date]];
    NSInteger current = 0;
    _intervalMonth = (endData - starDate) + 1;
    
    // 计算一行有几个 cell
    _columnCount = 1;
    if (_caledarType == CalendarTypeYear) {
        _columnCount = 3;
    }
    
    for (int i = 0 ; i < _intervalMonth; i++) {
        
        for (int j = 1; j <= 12; j++) {
            
            NSDate *date = [[ZCalendarDate getFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%d-1", starDate + i, j]];
            [_dateArray addObject:date];
            
            // 如果是当月,则记录下来,稍后要滚动到这里
            if ((starDate + i) == [today year] && j == [today month]) {
                current = i * (12 / _columnCount) + j / _columnCount - 1;
            }
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self setContentOffset:CGPointMake(0,
                                           current * (_cellSize.height + _layout.minimumLineSpacing) + ([today year] - _starYear) * _layout.headerReferenceSize.height) animated:YES];
    });
}

- (void)setCaledarType:(CalendarType)caledarType {
    _caledarType = caledarType;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setDateTextColor:(UIColor *)dateTextColor {
    _dateTextColor = dateTextColor;
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _intervalMonth;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ZCalendarDrawViewCell";
    ZCalendarDrawViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.caledarType = _caledarType;
    cell.lineColor = _lineColor;
    cell.dateTextColor = _dateTextColor;
    [cell setDate:_dateArray[indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGSize size;
//    if (_caledarType == CalendarTypeYear) {
//        size = CGSizeMake((_cellSize.width - 20) / _columnCount, _cellSize.height);
//    } else {
//        size = CGSizeMake(_cellSize.width, _cellSize.height);
//    }
    return CGSizeMake(_cellSize.width, _cellSize.height);;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return _cellEdgeInsets;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ZCalendarYearHeardView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ZCalendarYearHeardView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableview = headerView;
    }
    
    reusableview.year = _starYear + indexPath.section;
    
    return reusableview;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSDateComponents *today = [ZCalendarDate getDateComponentsByDate:[NSDate date]];
//    
//    _columnCount = 1;
//    NSInteger i = (_starYear + indexPath.section - _starYear);
//    NSInteger height = (i * (12 / _columnCount) + indexPath.row / _columnCount - 1) * (_cellSize.height + _layout.minimumLineSpacing) + i * _layout.headerReferenceSize.height;
//    
//    [collectionView performBatchUpdates:^{
//        _caledarType = CalendarTypeMonth;
//        
//    } completion:^(BOOL finished) {
//        
//        [collectionView reloadData];
//        [self setContentOffset:CGPointMake(0,
//                                           height) animated:YES];
//    }];
//    
//}



@end
