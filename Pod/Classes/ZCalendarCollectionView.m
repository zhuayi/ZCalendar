//
//  ZCalendarScroolView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarCollectionView.h"
#import "NSDate+ZCalendar.h"
#import "NSString+ZCalendar.h"
//#import "ZCalendarYearHeardView.h"
@implementation ZCalendarCollectionView {
    NSMutableArray *_dateArray;
    NSInteger _intervalMonth;
    NSInteger _columnCount;
    NSDateComponents *_today;
    
    NSString *_headetViewClassName;
}


- (instancetype)initWithFrame:(CGRect)frame headetViewClassName:(NSString *)headetViewClassName
{
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        //注册Cell，必须要有
        [self registerClass:[ZCalendarDrawViewCell class] forCellWithReuseIdentifier:@"ZCalendarDrawViewCell"];
        
        _headetViewClassName = headetViewClassName;
        [self registerClass:[NSClassFromString(headetViewClassName) class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        _dateArray = [NSMutableArray arrayWithCapacity:0];
        
        self.zcalendarStyle.cellSize = self.frame.size;
    }
    return self;
}


- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData {
    _starYear = starDate;
    _endYear = endData;
    
    _today = [[NSDate date] getDateComponentsByDate];
    _intervalMonth = (endData - starDate) + 1;
    
    // 计算一行有几个 cell
    _columnCount = 1;
    if (_caledarType == CalendarTypeYear) {
        _columnCount = 3;
    }
    
    for (int i = 0 ; i < _intervalMonth; i++) {
        
        NSMutableArray *monthArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 1; j <= 12; j++) {
            
            NSDate *date = [[NSString stringWithFormat:@"%d-%d-1", (int)starDate + i, j] dateFromString];
            [monthArray addObject:date];
        }
        
        [_dateArray addObject:monthArray];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:([_today month] - 1) inSection:([_today year] - _starYear)]
                     atScrollPosition:UICollectionViewScrollPositionTop
                             animated:YES];
        
    });
}

- (void)setCaledarType:(CalendarType)caledarType {
    _caledarType = caledarType;
}

- (NSMutableDictionary *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _dataArray;
}

//- (void)setLineColor:(UIColor *)lineColor {
//    _lineColor = lineColor;
//}
//
//- (void)setDateTextColor:(UIColor *)dateTextColor {
//    _dateTextColor = dateTextColor;
//}

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
    cell.zcalendarStyle = _zcalendarStyle;
    [cell setDate:_dateArray[indexPath.section][indexPath.row]];

    NSDateComponents *components = [_dateArray[indexPath.section][indexPath.row] getDateComponentsByDate];
    if ([_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld", components.year, components.month]]) {
        cell.dataArray = [_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld", components.year, components.month]];
    }
    
    [cell setNeedsDisplay];
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
    return _zcalendarStyle.cellSize;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return _zcalendarStyle.cellEdgeInsets;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    }
    
    if ([reusableview respondsToSelector:@selector(setYear:)]) {
        
        [reusableview performSelector:@selector(setYear:) withObject:_dateArray[indexPath.section][indexPath.row]];
    }
    
    return reusableview;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.frame.size.width, _zcalendarStyle.sectionHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


#pragma mark - scrollVieDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:scrollView.contentOffset];
//    
    ZCalendarDrawViewCell *cell = (ZCalendarDrawViewCell *)[self cellForItemAtIndexPath:indexPath];
//    NSLog(@"year : %@", cell.currentDateComponents);
    [_collectionViewDelegate didShowLeftTopCell:cell];
}

@end
