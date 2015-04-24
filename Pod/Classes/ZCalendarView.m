//
//  ZCalendarScroolView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarView.h"
#import "NSDate+ZCalendar.h"
#import "NSString+ZCalendar.h"
//#import "ZCalendarYearHeardView.h"
@implementation ZCalendarView {
    NSMutableArray *_dateArray;
    NSInteger _intervalMonth;
    NSDateComponents *_today;
    
    NSString *_headetViewClassName;
}


- (instancetype)initWithFrame:(CGRect)frame headetViewClassName:(NSString *)headetViewClassName scrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _layout = [[UICollectionViewFlowLayout alloc] init];
//    _layout.scrollDirection = scrollDirection;
    [_layout setScrollDirection:scrollDirection];
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //注册Cell，必须要有
        [self registerClass:[ZCalendarDrawViewCell class] forCellWithReuseIdentifier:@"ZCalendarDrawViewCell"];
        
        if (headetViewClassName) {
            
            _headetViewClassName = headetViewClassName;
            [self registerClass:[NSClassFromString(headetViewClassName) class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        }
        
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
   
    NSMutableArray *daysArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0 ; i < _intervalMonth; i++) {
        
        NSMutableArray *monthArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 1; j <= 12; j++) {
            
            NSDate *date = [[NSString stringWithFormat:@"%d-%d-1", (int)starDate + i, j] dateFromString];
            
            [monthArray addObject:date];
            
            if (_caledarType == CalendarTypeWeek) {
                NSInteger days = [date getDays];
                for (int n = 1; n <= days ; n++) {
                    NSDate *date = [[NSString stringWithFormat:@"%d-%d-%d", (int)starDate + i, j, n] dateFromString];
                    [daysArray addObject:date];
                }
            }
        }
        
        [_dateArray addObject:monthArray];
    }
    

    if (_caledarType == CalendarTypeWeek) {
    
        // 取第一个日期,判断是周几
        NSDate *firstDate = [daysArray firstObject];
        NSDateComponents *firstComponents = [firstDate getDateComponentsByDate];
        for (int i = 1; i< firstComponents.weekday; i++) {
            
            NSDate *date = [firstDate getDateByDaysAgo: 0 - i];
            [daysArray insertObject:date atIndex:0];
        }
        
        // 取最后日期,判断是周几
        NSDate *lastDate = [daysArray lastObject];
        NSDateComponents *lastComponents = [lastDate getDateComponentsByDate];
        for (int i = 1; i<= ( 7 - lastComponents.weekday); i++) {
            
            NSDate *date = [lastDate getDateByDaysAgo:i];
            [daysArray addObject:date];
        }
        
        [_dateArray removeAllObjects];
        for (int i = 0; i< (daysArray.count / 7 ); i++) {
                [_dateArray addObject:daysArray[i*7]];
        }
        
        [daysArray removeAllObjects];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_caledarType != CalendarTypeWeek) {
                    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:([_today month] - 1) inSection:([_today year] - _starYear)]
                                 atScrollPosition:UICollectionViewScrollPositionTop
                                         animated:YES];
        } else {
            
        }

//        
//        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:([_today month] - 1) inSection:([_today year] - _starYear)]
//                     atScrollPosition:UICollectionViewScrollPositionTop
//                             animated:YES];
        
    });
}

- (ZCalendarStyle *)zcalendarStyle {
    
    if (!_zcalendarStyle) {
        _zcalendarStyle = [[ZCalendarStyle alloc] init];
    }
    
    return _zcalendarStyle;
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


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_caledarType == CalendarTypeWeek) {
        
        return [_dateArray count];
    }
    return [_dateArray[section] count];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (_caledarType == CalendarTypeWeek) {
        
        return 1;
        
    } else {
       
        return _intervalMonth;
    }
    
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ZCalendarDrawViewCell";
    ZCalendarDrawViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.caledarType = _caledarType;
    cell.zcalendarStyle = _zcalendarStyle;
//
    
    if (_caledarType == CalendarTypeWeek) {
        cell.firstDate = _dateArray[indexPath.row];
    } else {
        cell.firstDate = _dateArray[indexPath.section][indexPath.row];
    }

    NSDateComponents *components = [cell.firstDate getDateComponentsByDate];
    if ([_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld", components.year, components.month]]) {
        cell.dataArray = [_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld", components.year, components.month]];
    }
    
//    [cell setNeedsDisplay];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return _zcalendarStyle.cellSize;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
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
    
    if (_zcalendarStyle.sectionHeight > 0) {
        
        return CGSizeMake(self.frame.size.width, _zcalendarStyle.sectionHeight);
    }
    
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return _zcalendarStyle.minimumLineSpacing;
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
