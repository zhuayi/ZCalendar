//
//  ZCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarView.h"
#import "ZCalendarDate.h"
@implementation ZCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *header;
        if (_caledarType != CalendarTypeYear) {
            header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
            header.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:header];
        }
        _zcalendarCollectionView = [[ZCalendarCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                             header.frame.size.width,
                                                                                             self.frame.size.width,
                                                                                             self.frame.size.height - header.frame.size.width)];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:_zcalendarCollectionView];
}


- (void)setCellEdgeInsets:(UIEdgeInsets)cellEdgeInsets {
    
    _cellEdgeInsets = cellEdgeInsets;
    
    _zcalendarCollectionView.cellEdgeInsets = cellEdgeInsets;
}

- (void)setCellSize:(CGSize)cellSize {
    
    _zcalendarCollectionView.cellSize = cellSize;
    _cellSize = cellSize;
}

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData {
    [_zcalendarCollectionView setYearInterval:starDate endDate:endData];
}

- (void)setCaledarType:(CalendarType)caledarType {
    _caledarType = caledarType;
    _zcalendarCollectionView.caledarType = caledarType;
    
//    if (caledarType == CalendarTypeYear) {
//        _zcalendarCollectionView.cellEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    }
}

@end
