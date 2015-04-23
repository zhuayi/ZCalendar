//
//  ZCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarView.h"

@implementation ZCalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _zcalendarCollectionView = [[ZCalendarCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                             _zcalendarStyle.header.frame.size.height,
                                                                                             self.frame.size.width,
                                                                                             self.frame.size.height - _zcalendarStyle.header.frame.size.height)];
        
        
        
        
    }
    return self;
}

- (void)setDelegate:(id<ZCalendarDelegate,ZCalendarCollectionViewDelegate>)delegate {
    
    _delegate = delegate;
    
    _zcalendarCollectionView.collectionViewDelegate = delegate;
    
    // 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(zCalendarCellViewClic:)
                                                 name:kZCalendarCellViewClick object:nil];
}

- (ZCalendarStyle *)zcalendarStyle {
    
    if (!_zcalendarStyle) {
        _zcalendarStyle = [[ZCalendarStyle alloc] init];
    }
    
    return _zcalendarStyle;
}


- (void)zCalendarCellViewClic:(NSNotification *)sender {
    
    [_delegate didClickDate:sender.object];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    _zcalendarCollectionView.zcalendarStyle = _zcalendarStyle;
    
    [self addSubview:_zcalendarCollectionView];
    
    if (_zcalendarStyle.header){
        [self addSubview:_zcalendarStyle.header];
    }
    
}


//- (void)setCellEdgeInsets:(UIEdgeInsets)cellEdgeInsets {
//    
//    _cellEdgeInsets = cellEdgeInsets;
//    
//    _zcalendarCollectionView.cellEdgeInsets = cellEdgeInsets;
//}

//- (void)setCellSize:(CGSize)cellSize {
//    
//    _zcalendarCollectionView.cellSize = cellSize;
//    _cellSize = cellSize;
//}

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData {
    [_zcalendarCollectionView setYearInterval:starDate endDate:endData];
}

- (void)setCaledarType:(CalendarType)caledarType {
    _caledarType = caledarType;
    _zcalendarCollectionView.caledarType = caledarType;
    
    if (_caledarType != CalendarTypeYear) {
//        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
//        _header.backgroundColor = [UIColor redColor];
    }
    
//    if (caledarType == CalendarTypeYear) {
//        _zcalendarCollectionView.cellEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s", __func__);
}

@end
